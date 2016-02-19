jwt = require 'jsonwebtoken'
bcrypt = require 'bcryptjs'
User = App.Models.User

maxPasswordBytes = 72

# Checks a plaintext (unhashed) password to make sure it is considered valid.
# For now, valid just means it's 72 bytes or under (the max length accepted
# by the bcryptjs library).
#
# @param password [String]
#   Plaintext (unhashed) password string to check.
#
# @return [Boolean]
#   Whether or not the password is acceptabled.
# ----------------------------------------------------------------------------
_passwordIsCorrectLength = (password) ->

  byteLength = Buffer.byteLength password, 'utf8'

  byteLength <= maxPasswordBytes

module.exports =

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

    unless process.env.JWT_SECRET
      console.error 'No JWT_SECRET environment variable is set!'

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
  #   Receives 3 parameters - errorKey, statusCode, and user.
  # ----------------------------------------------------------------------------
  authenticate: (email, password, callback) ->

    unless _passwordIsCorrectLength password
      return callback 'AUTH_PASSWORD_TOO_LONG'

    user = new User email: email

    user.fetch().then (user) ->

      unless user
        return callback 'AUTH_USER_NOT_FOUND'

      unless user.passwordIsValid password
        return callback 'AUTH_PASSWORD_INCORRECT'

      # Success!
      callback null, user

    .catch (err) ->

      callback 'AUTH_UNKNOWN'

  # Creates a new user account.
  #
  # @param email [String]
  # @param password [String]
  # @param callback [Function]
  #   Receives 3 parameters - errorKey, statusCode, and user.
  # ----------------------------------------------------------------------------
  register: (email, password, callback) ->

    user = new User email: email

    user.fetch().then (foundUser) ->

      # Email already exists
      if foundUser
        return callback 'AUTH_EMAIL_EXISTS'

      user.save( password: password ).then (newUser) ->
        # Success!
        callback null, newUser

    .catch (err) ->

      callback 'AUTH_UNKNOWN'
