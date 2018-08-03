validator = require 'validator'

Feed = require '../models/Feed'

module.exports = (app) ->

  { ParserService } = app.services

  # Creates a new feed with the given URL then returns the model. If a feed with
  # that URL already exists, then the model for the existing feed is returned.
  create: (req, res) ->

    feedUrl = req.body.url

    unless feedUrl
      return res.error 'MISSING_REQUEST_BODY_PARAMS', 'url'

    unless feedUrl.search(/https?:\/\//) is 0
      feedUrl = "http://#{ feedUrl }"

    validatorConfig =
      require_protocol: true
      require_valid_prototcol: true
      protocols: ['http', 'https']

    unless validator.isURL feedUrl, validatorConfig
      return res.error 'INVALID_REQUEST_BODY_PARAMS', 'url'

    params = url: feedUrl
    feed = new Feed params

    Feed.create params, (err, newFeed) ->

      # 11000 is the code for errors due to duplicate unique indices. In our
      # case, the `url` field is unique.
      if err?.code is 11000
        return Feed.findOne params, (err, existingFeed) ->
          res.json existingFeed
      else
        return res.error 'FEED_UNKNOWN_ERROR'

      ParserService.processFeed newFeed, (err) ->

        unless err
          return res.json newFeed

        newFeed.remove ->
          return res.error 'INVALID_REQUEST_BODY_PARAMS', 'url'

  # Forces a given feed to immediately re-index
  refresh: (req, res) ->

    Feed.findById req.params.id, (err, feed) ->
      ParserService.processFeed feed, ->
        res.json feed
