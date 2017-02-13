read = require 'node-readability'
moment = require 'moment'

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

  # Fetches a single article. If there's no body copy saved (or it's outdated),
  # this call will also fetch the article html and store it before returning
  # the article data.
  get: (req, res) ->

    Article.findById req.params.id, (err, doc) ->
      yesterday = moment().utc().subtract 1, 'days'
      updatedAt = moment(doc.updatedAt).utc()

      if doc.body and updatedAt > yesterday
        return res.json doc

      requestOpts =
        headers:
          'user-agent': 'Broadsheet RSS Reader (github.com/claflamme/broadsheet)'

      read doc.url, requestOpts, (err, article, httpRes) ->
        doc.body = article?.content or null
        doc.markModified 'body'
        doc.save (err, savedDoc) ->
          res.json savedDoc

        article.close()
