validator = require 'validator'
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

    unless feedUrl
      return res.error 'FEED_URL_REQUIRED'

    unless feedUrl.search(/https?:\/\//) is 0
      feedUrl = "http://#{ feedUrl }"

    validatorConfig =
      require_protocol: true
      require_valid_prototcol: true
      protocols: ['http', 'https']

    unless validator.isURL feedUrl, validatorConfig
      return res.error 'INVALID_REQUEST_BODY_PARAMS', 'url'

    params = url: feedUrl

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
  @api { patch } /api/feeds/:id Refresh
  @apiDescription Forces a given feed to immediately re-index
  ###
  refresh: (req, res) ->

    Feed.findById req.params.id, (err, feed) ->
      ParserService.processFeed feed, ->
        res.json feed
