AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
UserController = App.Controllers.UserController
FeedController = App.Controllers.FeedController
SubscriptionController = App.Controllers.SubscriptionController

module.exports = (router) ->

  router.post '/api/auth/authenticate', AuthController.authenticate
  router.post '/api/auth/register', AuthController.register

  router.get '/api/user', UserController.get

  # Subscriptions are "instances" of a feed that belong to a user.
  router.get '/api/subscriptions', SubscriptionController.list
  router.post '/api/subscriptions', SubscriptionController.create
  router.get '/api/subscriptions/:id', SubscriptionController.show
  router.patch '/api/subscriptions/:id', SubscriptionController.update
  router.delete '/api/subscriptions/:id', SubscriptionController.delete

  router.get '/api/feeds', FeedController.list
  router.get '/api/feeds/outdated', FeedController.outdated
  router.post '/api/feeds/:feedId', FeedController.refresh

  router.get '/reader', (req, res) ->
    res.render 'main'

  # Catch-all route for using browserHistory in react-router.
  router.get '*', (req, res) ->
    res.render 'main'
