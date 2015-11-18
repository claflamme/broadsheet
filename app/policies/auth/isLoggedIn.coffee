module.exports = class IsLoggedIn

  check: (req, res, next) ->

    if req.isAuthenticated()
      return next()

    res.redirect '/'
