AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController

module.exports = (router) ->

  router.post '/authenticate', AuthController.authenticate
  router.post '/register', AuthController.register

  router.post '/feeds', FeedController.create
