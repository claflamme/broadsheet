AuthService = App.Services.AuthService

module.exports = class AuthController

  authenticate: (req, res) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    AuthService.authenticate email, password, (err, user, statusCode) ->

      if statusCode isnt 200
        return res.status(statusCode).json error: message: err

      AuthService.generateToken user, (token) ->
        res.status(statusCode).json token: token

  register: (req, res) ->

    { email, password } = req.body

    unless email and password
      return @_emailAndPasswordRequired res

    AuthService.register email, password, (status, user, err) ->
      output = if status isnt 200 then error: message: err else user
      res.status(status).json output

  _emailAndPasswordRequired: (res) ->

    data = error: message: 'Both email and password are required.'

    res.status(400).json data
