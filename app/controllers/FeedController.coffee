Feed = App.Models.Feed

module.exports = class FeedController

  create: (req, res) ->

    { url } = req.body

    unless url
      return res.status(400).json error: message: 'The url param is required.'

    feed = new Feed req.body.url

    feed.save().then (feed) ->
      res.json feed
    .catch (err) ->
      res.status(500).json error: message: 'There was an unknown problem.'
