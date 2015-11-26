jwt = require 'jsonwebtoken'
bcrypt = require 'bcryptjs'
User = App.Models.User

module.exports = class AuthService

  # Generates a new JSON Web Token using the given user model's info.
  #
  # @param user [bookshelf.Model]
  #   Bookshelf model of the user for which to generate the token.
  # @param callback [Function]
  #   Receives the hashed token as its only parameter.
  #
  # @return [String] A signed JSON Web Token.
  # ----------------------------------------------------------------------------
  generateToken: (user, callback) ->

    payload = {}
    secret = process.env.JWT_SECRET
    options = subject: user.get 'id'

    jwt.sign payload, secret, options, callback

  # Attempts to find and authenticate a user.
  #
  # @param email [String]
  #   The user's email address.
  # @param password [String]
  #   User's unhashed password, to be compared with the hash.
  # @param callback [Function]
  #   Receives 3 parameters - `statusCode`, the HTTP response code to return;
  #   `user`, the user model if successful; `errorMessage`, if unsuccessful.
  # ----------------------------------------------------------------------------
  authenticate: (email, password, callback) ->

    user = new User email: email

    user.fetch().then (user) ->

      unless user
        return callback 404, null, 'User not found.'

      unless user.passwordIsValid password
        return callback 401, null, 'Incorrect password.'

      callback 200, user

    .catch (err) ->

      callback 500, null, 'There was an unknown error.'
