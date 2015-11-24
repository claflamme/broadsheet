TokenService = App.Services.TokenService

module.exports = class AuthController

  create: (req, res, next) ->

    email = req.body.email
    password = req.body.password

    unless email and password
      return res.status(400).json
        error: message: 'Both email and password are required.'

    TokenService.create email, password, (status, json) ->
      res.status(status).json json

  index: (req, res) ->

    res.render 'auth/login'
