UserController = App.Controllers.UserController
JWTController = App.Controllers.JWTController

module.exports = (router) ->

  router.get '/', UserController.test

  # User registration
  router.get '/register', UserController.register
  router.post '/register', UserController.create

  # Authentication
  router.get '/login', JWTController.index
  router.post '/login', JWTController.create

  router.get '/auth', App.Policies.auth.isLoggedIn, (req, res) ->
    res.render 'dashboard'
