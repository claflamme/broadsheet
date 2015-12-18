AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
UserController = App.Controllers.UserController

module.exports = (router) ->

  router.post '/auth/authenticate', AuthController.authenticate
  router.post '/auth/register', AuthController.register

  router.get '/user', UserController.get
  router.get '/user/feeds', UserController.getFeeds

  router.post '/feeds', FeedController.add
