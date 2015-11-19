module.exports = class SessionController

  # Log in (i.e. create a new session)
  create: (req, res, next) ->

    opts =
      successRedirect: '/auth'
      failureRedirect: '/login'
      failureFlash: true
      session: false

    if req.body.email and req.body.password
      App.Passport.authenticate('local-login', opts)(req, res, next)
    else
      # Both email and password are required
      res.redirect opts.failureRedirect

  # Log out (i.e. delete the active session)
  delete: (req, res) ->

    req.logout()
    res.redirect App.Config.auth.logoutRedirect

  index: (req, res) ->

    res.render 'auth/login'
