module.exports = (app, router) ->

  {
    FeedController
    SubscriptionController
    ProxyController
    ArticleController
  } = app.controllers

  # Subscriptions
  router.get '/api/subscriptions', SubscriptionController.list
  router.post '/api/subscriptions', SubscriptionController.create
  router.patch '/api/subscriptions', SubscriptionController.updateMany
  router.get '/api/subscriptions/articles', ArticleController.all
  router.get '/api/subscriptions/:id', SubscriptionController.show
  router.patch '/api/subscriptions/:id', SubscriptionController.update
  router.delete '/api/subscriptions/:id', SubscriptionController.delete

  # Feeds
  router.post '/api/feeds', FeedController.create
  router.patch '/api/feeds/:id', FeedController.refresh
  router.get '/api/feeds/:id/articles', ArticleController.byFeed

  # Articles
  router.get '/api/articles/:id', ArticleController.get

  # Proxy for images
  router.get '/api/proxy', ProxyController.get

  # Catch-all route for using browserHistory in react-router.
  router.get '*', (req, res) ->
    res.render 'main'
