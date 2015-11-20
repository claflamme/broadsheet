User = App.Models.User
AuthService = App.Services.AuthService

module.exports = class JWTController

  create: (req, res, next) ->

    unless req.body.email and req.body.password
      return res.status(400).json
        error: message: 'Both email and password are required.'

    user = new User()
    user.set 'email', req.body.email

    user.fetch().then (user) ->

      unless user
        return res.status(404).json error: message: 'User not found'

      unless AuthService.passwordMatchesSync req.body.password, user.get('password')
        return res.status(401).json error: message: 'Incorrect password'

      return res.json user
    .catch (err) ->
      console.log err
      res.status(500).json error: message: 'There was an unknown error.'

  index: (req, res) ->

    res.render 'auth/login'

  _returnUserNotFound: (req, res) ->

    return res.status(404).json error: message: 'User not found'
