Article = App.Models.Article
Subscription = App.Models.Subscription

module.exports =

  ###
  @apiGroup Articles
  @api { get } /api/subscriptions/articles All
  @apiDescription Returns articles from all of a user's subscriptions.
  ###
  all: (req, res) ->

    Subscription.find { user: req.user.sub }, (err, subscriptions) ->

      unless subscriptions
        return res.json []

      feedIds = subscriptions.map (subscription) ->
        subscription.feed

      query = feed: { $in: feedIds }
      options = sort: '-publishedAt'

      Article.paginate query, options, (err, articles) ->
        res.json articles or []

  ###
  @apiGroup Articles
  @api { get } /api/subscriptions/:id/articles By subscription
  @apiDescription Fetches all articles belonging to a given subscription.
  ###
  bySubscription: (req, res) ->

    Subscription.findById req.params.id, (err, subscription) ->

      unless subscription
        return res.json []

      query = feed: subscription.feed
      options = sort: '-publishedAt'

      Article.paginate query, options, (err, articles) ->
        res.json articles or []
