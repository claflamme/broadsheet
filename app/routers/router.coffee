AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
UserController = App.Controllers.UserController

module.exports = (router) ->

  router.post '/auth/authenticate', AuthController.authenticate
  router.post '/auth/register', AuthController.register
  router.get '/auth/current', AuthController.current

  router.post '/feeds', FeedController.create
