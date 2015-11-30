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

    payload = {}
    secret = process.env.JWT_SECRET
    options =
      subject: user.get 'id'
      expiresIn: '7d'

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
      return callback 400, null, 'Password is too long.'

    user = new User email: email

    user.fetch().then (user) ->

      unless user
        return callback 404, null, 'User not found.'

      unless user.passwordIsValid password
        return callback 401, null, 'Incorrect password.'

      callback 200, user

    .catch (err) ->

      callback 500, null, 'There was an unknown error.'

  register: (email, password, callback) ->

    user = new User email: email

    user.fetch().then (foundUser) ->

      if foundUser
        return callback 400, null, 'Email already exists.'

      user.save( password: password ).then (newUser) ->
        callback 200, newUser
      .catch (err) ->
        callback 500, null, 'There was an unknown error creating a new user.'

    .catch (err) ->

      callback 500, null, 'There was an unknown error querying users.'


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
