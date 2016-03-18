Feed = App.Models.Feed
ParserService = App.Services.ParserService

module.exports =

  ###
  @apiGroup Feeds
  @api { post } /api/feeds Create
  @apiDescription
    Creates a new feed with the given URL then returns the model. If a feed with
    that URL already exists, then the model for the existing feed is returned.
  ###
  create: (req, res) ->

    feedUrl = req.body.url
    params = url: feedUrl

    unless feedUrl
      return res.error 'FEED_URL_REQUIRED'

    Feed.findOne params, (err, feed) ->

      if feed
        return res.json feed

      Feed.create params, (err, feed) ->
        res.json feed

  ###
  @apiGroup Feeds
  @api { get } /api/feeds List
  @apiDescription Returns a list of all feeds being indexed by the system.
  ###
  list: (req, res) ->

    new Feed().fetchAll().then (feeds) ->
      res.json feeds.serialize()

  ###
  @apiGroup Feeds
  @api { get } /api/feeds/outdated Outdated
  @apiDescription Returns a list of all feeds that need to be re-indexed.
  ###
  outdated: (req, res) ->

    new Feed().outdated().fetchAll().then (feeds) ->
      res.json feeds.serialize()

  ###
  @apiGroup Feeds
  @api { patch } /api/feeds/:id Refresh
  @apiDescription Forces a given feed to immediately re-index
  ###
  refresh: (req, res) ->

    new Feed().where('id', req.params.feedId).fetch().then (feed) ->
      ParserService.processFeed feed, ->
        res.json feed.serialize()
