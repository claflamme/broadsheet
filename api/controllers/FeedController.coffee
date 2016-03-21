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

    Feed.create params, (err, newFeed) ->

      # 11000 is the code for errors due to duplicate unique indices. In our
      # case, the `url` field is unique.
      if err?.code is 11000
        return Feed.findOne params, (err, existingFeed) ->
          res.json existingFeed

      ParserService.processFeed newFeed, ->
        res.json newFeed

  ###
  @apiGroup Feeds
  @api { get } /api/feeds List
  @apiDescription Returns a list of all feeds being indexed by the system.
  ###
  list: (req, res) ->

    Feed.find {}, (err, feeds) ->
      res.json feeds

  ###
  @apiGroup Feeds
  @api { get } /api/feeds/outdated Outdated
  @apiDescription Returns a list of all feeds that need to be re-indexed.
  ###
  outdated: (req, res) ->

    Feed.findOutdated (err, feeds) ->
      res.json feeds

  ###
  @apiGroup Feeds
  @api { patch } /api/feeds/:id Refresh
  @apiDescription Forces a given feed to immediately re-index
  ###
  refresh: (req, res) ->

    Feed.findById req.params.id, (err, feed) ->
      ParserService.processFeed feed, ->
        res.json feed
