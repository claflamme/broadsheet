AuthService = App.Services.AuthService

module.exports = class AuthController

  authenticate: (req, res) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    AuthService.authenticate email, password, @_sendSuccessResponse.bind @, res

  register: (req, res) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    AuthService.register email, password, @_sendSuccessResponse.bind @, res

  _sendSuccessResponse: (res, err, statusCode, user) ->

    if statusCode isnt 200
      return res.status(statusCode).json error: message: err

    AuthService.generateToken user, (token) ->
      res.json token: token, user: user

  _emailAndPasswordRequired: (res) ->

    data = error: message: 'Both email and password are required.'

    res.status(400).json data
