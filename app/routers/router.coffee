UserController = App.Controllers.UserController
AuthController = App.Controllers.AuthController

module.exports = (router) ->

  router.get '/', UserController.test

  # User registration
  router.get '/register', UserController.register
  router.post '/register', UserController.create

  # Authentication
  router.get '/login', AuthController.index
  router.post '/login', AuthController.create

  router.get '/auth', App.Policies.auth.isLoggedIn, (req, res) ->
    res.render 'dashboard'
