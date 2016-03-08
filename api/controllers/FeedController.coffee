Feed = App.Models.Feed
ParserService = App.Services.ParserService

module.exports =

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
