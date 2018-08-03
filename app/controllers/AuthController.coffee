User = require '../models/User'

module.exports = (app) ->
  { AuthService } = app.services

  authenticate: (req, res) ->

    AuthService.createAuthRequest req.body.email, (err) ->
      if err
        return res.error err
      res.json message: 'Success!'

  redeemAuthRequest: (req, res) ->

    AuthService.redeemNonce req.query.nonce, (err, token) ->
      if err
        return res.error err
      res.json token: token

  getAuthenticatedUser: (req, res) ->

    User.findById req.user.sub, (err, user) ->
      return res.json { user }
