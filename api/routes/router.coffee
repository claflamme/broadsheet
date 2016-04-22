AuthController = App.Controllers.AuthController
FeedController = App.Controllers.FeedController
FeedController = App.Controllers.FeedController
SubscriptionController = App.Controllers.SubscriptionController
ProxyController = App.Controllers.ProxyController
ArticleController = App.Controllers.ArticleController

module.exports = (router) ->

  router.post '/api/auth/authenticate', AuthController.authenticate
  router.post '/api/auth/register', AuthController.register

  router.get '/api/subscriptions', SubscriptionController.list
  router.post '/api/subscriptions', SubscriptionController.create
  router.get '/api/subscriptions/articles', ArticleController.all
  router.get '/api/subscriptions/:id', SubscriptionController.show
  router.patch '/api/subscriptions/:id', SubscriptionController.update
  router.delete '/api/subscriptions/:id', SubscriptionController.delete

  router.get '/api/feeds', FeedController.list
  router.post '/api/feeds', FeedController.create
  router.patch '/api/feeds/:id', FeedController.refresh
  router.get '/api/feeds/:id/articles', ArticleController.byFeed

  router.get '/api/proxy', ProxyController.get
  router.get '/api/proxy/article', ProxyController.getArticle

  # Catch-all route for using browserHistory in react-router.
  router.get '*', (req, res) ->
    res.render 'main'
