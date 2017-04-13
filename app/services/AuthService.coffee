jwt = require 'jsonwebtoken'
uuid = require 'node-uuid'

getOrCreateUser = (User, email, cb) ->

  User.findOne { email: email }, (err, foundUser) ->

    if foundUser
      return cb err, foundUser

    User.create { email }, cb

module.exports = (app) ->

  { User, Token, AuthRequest } = app.models
  { MailHelper } = app.helpers

  generateToken: (user, callback) ->

    payload = {}
    secret = process.env.JWT_SECRET
    options =
      subject: user._id.toString()
      jwtid: uuid.v4()

    # TODO: this is all garbage.
    jwt.sign payload, secret, options, (err, signedToken) ->
      if err
        return callback err
      decodedToken = jwt.decode signedToken
      # .skip() doesn't work with .remove(), so this has to be done the hard way
      Token
      .find user: user._id
      .sort '-iat'
      .skip 4
      .exec (err, tokenDocList) ->
        ids = tokenDocList.map (tokenDoc) -> tokenDoc._id
        # TODO: don't call remove() if ids[] is empty.
        Token.remove _id: { $in: ids }, (err) ->
          newTokenDoc =
            jti: decodedToken.jti
            iat: decodedToken.iat
            user: user._id
          Token.create newTokenDoc, (err) ->
            callback err, signedToken

  # Creates and saves an authentication request. Sends an email containing a
  # link to validate the user and get a token.
  createAuthRequest: (email, cb) ->

    getOrCreateUser User, email, (err, user) ->

      if err
        return cb 'UNKNOWN_ERROR'

      AuthRequest.create { nonce: uuid.v4(), user: user }, (err, authRequest) ->

        if err
          return cb 'UNKNOWN_ERROR'

        mailData =
          from: app.config.auth.email.from
          to: user.email
          subject: app.config.auth.email.subject
          callbackUrl: app.config.auth.email.callbackUrl
          nonce: authRequest.nonce

        MailHelper.send 'auth_request', mailData, (mailErr) ->
          if mailErr
            return cb 'UNKNOWN_ERROR'
          cb null

  redeemNonce: (nonce, cb) ->

    query = AuthRequest.findOne { nonce }
    token = ''

    query.populate('user').exec (err, authRequest) =>

      if err
        return cb 'UNKNOWN_ERROR'

      unless authRequest
        return cb 'RESOURCE_NOT_FOUND'

      @generateToken authRequest.user, (err, token) ->
        authRequest.remove (err) ->
          cb null, token
