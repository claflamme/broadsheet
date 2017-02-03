module.exports = (app) ->

  { Article, Subscription } = app.models

  # Returns articles from all of a user's subscriptions.
  all: (req, res) ->

    Subscription.find { user: req.user.sub }, (err, subscriptions) ->

      unless subscriptions
        return res.json []

      feedIds = subscriptions.map (subscription) ->
        subscription.feed

      query =
        feed:
          $in: feedIds

      options =
        sort: '-publishedAt'
        page: parseInt req.query.page
        limit: 20

      Article.paginate query, options, (err, articles) ->
        res.json articles or []

  # Fetches all articles belonging to a given subscription.
  byFeed: (req, res) ->

    query =
      feed: req.params.id

    options =
      sort: '-publishedAt'
      page: parseInt req.query.page
      limit: 20

    Article.paginate query, options, (err, articles) ->
      res.json articles or []
