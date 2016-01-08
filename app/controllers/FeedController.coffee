Feed = App.Models.Feed

module.exports = class FeedController

  list: (req, res) ->

    new Feed().fetchAll().then (feeds) ->
      res.json feeds.serialize()
