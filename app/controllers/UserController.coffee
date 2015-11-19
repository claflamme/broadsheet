bcrypt = require 'bcryptjs'
User = App.Models.User

module.exports = class UserController

  test: (req, res) ->

    res.render 'main'

  register: (req, res) ->

    res.render 'auth/register'

  create: (req, res, next) ->

    opts =
      successRedirect: '/auth'
      failureRedirect: '/register'
      session: false

    if req.body.email and req.body.password
      App.Passport.authenticate('local-register', opts)(req, res, next)
    else
      # Both email and password are required
      res.redirect opts.failureRedirect
