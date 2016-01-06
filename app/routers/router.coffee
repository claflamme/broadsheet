AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
UserController = App.Controllers.UserController

module.exports = (router) ->

  router.post '/auth/authenticate', AuthController.authenticate
  router.post '/auth/register', AuthController.register

  router.get '/user', UserController.get

  # Feeds, as they relate to a given user.
  router.get '/user/feeds', UserController.getFeeds
  router.post '/user/feeds', FeedController.subscribe
  router.get '/user/subscriptions/:id', UserController.getSubscription
  router.delete '/user/feeds/:id', FeedController.unsubscribe
