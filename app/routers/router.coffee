UserController = App.Controllers.UserController
SessionController = App.Controllers.SessionController

module.exports = (router) ->

  router.get '/', UserController.test

  # User registration
  router.get '/register', UserController.register
  router.post '/register', UserController.create

  # Authentication
  router.get '/login', SessionController.index
  router.post '/login', SessionController.create

  router.get '/auth', App.Policies.auth.isLoggedIn, (req, res) ->
    res.render 'dashboard'

  router.post '/logout', SessionController.delete
