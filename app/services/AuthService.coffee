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
    options =
      subject: user.get 'id'

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

    unless @_passwordIsValid password
      return callback 'Password is too long.', 400, null

    user = new User email: email

    user.fetch().then (user) ->

      unless user
        return callback 'User not found.', 404, null

      unless user.passwordIsValid password
        return callback 'Incorrect password.', 401, null

      callback null, 200, user

    .catch (err) ->

      callback 'There was an unknown error.', 500, null

  # Creates a new user account.
  #
  # @param email [String]
  # @param password [String]
  # @param callback [Function]
  #   Receives 3 parameters - `statusCode`, the HTTP response code to return;
  #   `user`, the user model if successful; `errorMessage`, if unsuccessful.
  # ----------------------------------------------------------------------------
  register: (email, password, callback) ->

    user = new User email: email

    user.fetch().then (foundUser) ->

      if foundUser
        return callback 'Email already exists.', 400, null

      user.save( password: password ).then (newUser) ->
        callback null, 200, newUser
      .catch (err) ->
        callback 'There was an unknown error creating a new user.', 500, null

    .catch (err) ->

      callback 'There was an unknown error querying users.', 500, null


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
  _passwordIsValid: (password) ->

    byteLength = Buffer.byteLength password, 'utf8'

    byteLength <= @maxPasswordBytes
