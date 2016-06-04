jwt = require 'jsonwebtoken'
bcrypt = require 'bcryptjs'
uuid = require 'node-uuid'

module.exports = (app) ->

  User = app.models.User
  Token = app.models.Token

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

  authenticate: (email, password, cb) ->

    unless User.passwordIsCorrectLength password
      return callback 'AUTH_PASSWORD_TOO_LONG'

    User.findOne { email: email }, (err, user) ->

      if err
        return cb 'UNKNOWN_ERROR'

      unless user
        return cb 'AUTH_USER_NOT_FOUND'

      unless user.passwordMatches password
        return cb 'AUTH_PASSWORD_INCORRECT'

      cb null, user

  register: (email, password, cb) ->

    user = new User { email, password }

    user.save (err, newUser) ->

      if err?.code is 11000
        return cb 'AUTH_EMAIL_EXISTS'

      if err
        return cb 'UNKNOWN_ERROR'

      cb null, newUser
