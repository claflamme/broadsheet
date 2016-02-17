Feed = App.Models.Feed

module.exports =

  list: (req, res) ->

    new Feed().fetchAll().then (feeds) ->
      res.json feeds.serialize()

  outdated: (req, res) ->

    new Feed().outdated().fetchAll().then (feeds) ->
      res.json feeds.serialize()
