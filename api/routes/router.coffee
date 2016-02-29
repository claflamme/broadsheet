AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
UserController = App.Controllers.UserController
FeedController = App.Controllers.FeedController
SubscriptionController = App.Controllers.SubscriptionController

module.exports = (router) ->

  router.post '/auth/authenticate', AuthController.authenticate
  router.post '/auth/register', AuthController.register

  router.get '/user', UserController.get

  # Subscriptions are "instances" of a feed that belong to a user.
  router.get '/subscriptions', SubscriptionController.list
  router.post '/subscriptions', SubscriptionController.create
  router.get '/subscriptions/:id', SubscriptionController.show
  router.patch '/subscriptions/:id', SubscriptionController.update
  router.delete '/subscriptions/:id', SubscriptionController.delete

  router.get '/feeds', FeedController.list
  router.get '/feeds/outdated', FeedController.outdated
  router.post '/feeds/:feedId', FeedController.refresh
