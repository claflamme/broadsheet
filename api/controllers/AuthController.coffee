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

  ###
  @apiGroup Auth

  @api { post } /api/auth/authenticate Authenticate
  @apiParam { String } email A valid email address.
  @apiParam { String } password Max 72 characters (bcrypt hard limit).

  @apiDescription
    Attempts to authenticate a set of credentials. Provides the user model and
    an auth token if successful.
  ###
  authenticate: (req, res) ->

    _validateAuthRequest req, res, AuthService.authenticate

  ###
  @apiGroup Auth

  @api { post } /api/auth/register Register
  @apiParam { String } email A valid email address.
  @apiParam { String } password Max 72 characters (bcrypt hard limit).

  @apiDescription
    Creates a new user account. If successful, returns the user model and
    an auth token.
  ###
  register: (req, res) ->

    _validateAuthRequest req, res, AuthService.register
