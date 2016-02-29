Feed = App.Models.Feed
CrawlerService = App.Services.CrawlerService

module.exports =

  list: (req, res) ->

    new Feed().fetchAll().then (feeds) ->
      res.json feeds.serialize()

  outdated: (req, res) ->

    new Feed().outdated().fetchAll().then (feeds) ->
      res.json feeds.serialize()

  refresh: (req, res) ->

    new Feed().where('id', req.params.feedId).fetch().then (feed) ->
      CrawlerService.processFeed feed, ->
        res.json feed.serialize()
