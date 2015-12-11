validator = require 'validator'
AuthService = App.Services.AuthService

module.exports = class AuthController

  authenticate: (req, res) ->

    @_processAuthRequest req, res, AuthService.authenticate

  register: (req, res) ->

    @_processAuthRequest req, res, AuthService.register

  _processAuthRequest: (req, res, callback) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    unless validator.isEmail email
      return @_sendEmailIsInvalid res

    done = @_sendResponse.bind @, res

    callback email, password, done

  _sendResponse: (res, err, statusCode, user) ->

    if statusCode isnt 200 and statusCode isnt 201
      return res.status(statusCode).json error: err

    AuthService.generateToken user, (token) ->
      res.json token: token, user: user

  _emailAndPasswordRequired: (res) ->

    data = error: App.Errors.AUTH_EMAIL_PASS_REQUIRED

    res.status(400).json data

  _sendEmailIsInvalid: (res) ->

    data = error: App.Errors.AUTH_INVALID_EMAIL

    res.status(400).json data
