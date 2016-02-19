validator = require 'validator'
AuthService = App.Services.AuthService

_validateAuthRequest = (req, res, callback) ->

  { email, password } = req.body

  unless email and password
    return res.error 'AUTH_MISSING_FIELD'

  unless validator.isEmail email
    return res.error 'AUTH_INVALID_EMAIL'

  done = _sendResponse.bind @, res

  callback email, password, done

_sendResponse = (res, errKey, user) ->

  if errKey
    return res.error errKey

  AuthService.generateToken user, (token) ->
    res.json token: token, user: user

module.exports =

  authenticate: (req, res) ->

    _validateAuthRequest req, res, AuthService.authenticate

  register: (req, res) ->

    _validateAuthRequest req, res, AuthService.register
