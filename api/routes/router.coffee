AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
UserController = App.Controllers.UserController
FeedController = App.Controllers.FeedController
SubscriptionController = App.Controllers.SubscriptionController
ProxyController = App.Controllers.ProxyController
ArticleController = App.Controllers.ArticleController

module.exports = (router) ->

  router.post '/api/auth/authenticate', AuthController.authenticate
  router.post '/api/auth/register', AuthController.register

  router.get '/api/user', UserController.get

  # Subscriptions are "instances" of a feed that belong to a user.
  router.get '/api/subscriptions', SubscriptionController.list
  router.post '/api/subscriptions', SubscriptionController.create
  router.get '/api/subscriptions/:feedIds', SubscriptionController.show
  router.patch '/api/subscriptions/:feedId', SubscriptionController.update
  router.delete '/api/subscriptions/:feedId', SubscriptionController.delete

  router.get '/api/feeds', FeedController.list
  router.get '/api/feeds/outdated', FeedController.outdated
  router.patch '/api/feeds/:feedId', FeedController.refresh

  router.get '/api/articles/:id', ArticleController.show

  router.get '/api/proxy', ProxyController.get

  # Catch-all route for using browserHistory in react-router.
  router.get '*', (req, res) ->
    res.render 'main'
