Feed = App.Models.Feed
User = App.Models.User

module.exports = class FeedController

  add: (req, res) ->

    { url } = req.body

    unless url
      return res.status(400).json error: message: 'The url param is required.'

    feed = new Feed url: req.body.url
    user = new User id: req.user.sub

    feed.fetch().then (foundFeed) ->

      if foundFeed?
        foundFeed.subscribers().query('where', 'id', '=', req.user.sub).count().then (count) ->
          unless count is 0
            return res.json foundFeed
          foundFeed.subscribers().attach(user).then ->
            res.json foundFeed
      else
        feed.save().then (newFeed) ->
          newFeed.subscribers().attach(user).then ->
            res.json newFeed

    .catch (err) ->
      res.status(500).json error: message: 'Unknown problem querying feeds.'
