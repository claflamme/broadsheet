jwt = require 'jsonwebtoken'
bcrypt = require 'bcryptjs'
User = App.Models.User

module.exports = class AuthService

  maxPasswordBytes: 72

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
  authenticate: (email, password, callback) =>

    # Password is too long.
    unless @_passwordIsCorrectLength password
      return callback App.Errors.AUTH_PASSWORD_TOO_LONG, 400, null

    user = new User email: email

    user.fetch().then (user) ->

      # User not found.
      unless user
        return callback App.Errors.AUTH_USER_NOT_FOUND, 404, null

      # Incorrect password.
      unless user.passwordIsValid password
        return callback App.Errors.AUTH_PASSWORD_INCORRECT, 400, null

      # Success!
      callback null, 200, user

    .catch (err) ->

      # Unknown error during authentication.
      callback App.Errors.AUTH_UNKNOWN_AUTHENTICATION, 500, null

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
        return callback App.Errors.AUTH_EMAIL_EXISTS, 400, null

      user.save( password: password ).then (newUser) ->
        # Success!
        callback null, 201, newUser
      .catch (err) ->
        # Unknown error while saving new user.
        callback App.Errors.AUTH_UNKNOWN_SAVING, 500, null

    .catch (err) ->

      callback App.Errors.AUTH_UNKNOWN_REGISTRATION, 500, null

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
  _passwordIsCorrectLength: (password) ->

    byteLength = Buffer.byteLength password, 'utf8'

    byteLength <= @maxPasswordBytes
