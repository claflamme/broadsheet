jwt = require 'jsonwebtoken'
bcrypt = require 'bcryptjs'
User = App.Models.User

module.exports =

  generateToken: (user, callback) ->

    payload = {}
    secret = process.env.JWT_SECRET
    options = subject: user._id

    jwt.sign payload, secret, options, callback

  authenticate: (email, password, cb) ->

    unless User.passwordIsCorrectLength password
      return callback 'AUTH_PASSWORD_TOO_LONG'

    User.findOne { email: email }, (err, user) ->

      if err
        return cb 'AUTH_UNKNOWN'

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
        console.err
        return cb 'AUTH_UNKNOWN'

      cb null, newUser
