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

      Article.find { feed: { $in: feedIds } }
      .sort '-publishedAt'
      .exec (err, articles) ->
        res.json articles or []
