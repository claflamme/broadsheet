jwt = require 'jsonwebtoken'
bcrypt = require 'bcryptjs'

module.exports = class AuthService

  # Generates a new JSON Web Token using the given user model's info.
  #
  # @param user [bookshelf.Model]
  #   Bookshelf model of the user for which to generate the token.
  # @param callback [Function]
  #   Receives the hashed token as its only parameter.

  generateToken: (user, callback) ->

    payload = {}
    secret = process.env.JWT_SECRET
    options = subject: user.get 'id'

    jwt.sign payload, secret, options, callback

  hashPassword: (password, callback) ->

    bcrypt.genSalt App.Config.auth.bcryptSaltRounds, (err, salt) ->
      bcrypt.hash password, salt, callback

  hashPasswordSync: (password) ->

    salt = bcrypt.genSaltSync App.Config.auth.bcryptSaltRounds

    bcrypt.hashSync password, salt

  passwordMatchesSync: (password, hash) ->

    bcrypt.compareSync password, hash
