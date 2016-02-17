moment = require 'moment'
Feed = App.Models.Feed

module.exports =

  list: (req, res) ->

    new Feed().fetchAll().then (feeds) ->
      res.json feeds.serialize()

  outdated: (req, res) ->

    threshold = moment().utc().subtract 10, 'minutes'

    new Feed().where('updated_at', '<', threshold).fetchAll().then (feeds) ->
      res.json feeds.serialize()
