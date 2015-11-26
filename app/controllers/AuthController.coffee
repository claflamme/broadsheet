AuthService = App.Services.AuthService

module.exports = class AuthController

  authenticate: (req, res) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    AuthService.authenticate email, password, (status, user, err) ->

      if status isnt 200
        return res.status(status).json error: message: err

      AuthService.generateToken user, (token) ->
        return res.status(status).json token: token

  register: (req, res) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    AuthService.register email, password, (status, data) ->
      res.status(status).json data

  _emailAndPasswordRequired: (res) ->

    data = error: message: 'Both email and password are required.'

    res.status(400).json data
