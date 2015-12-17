Feed = App.Models.Feed
User = App.Models.User

module.exports = class FeedController

  add: (req, res) ->

    { url } = req.body

    unless url
      return res.status(400).json error: message: 'The url param is required.'

    feed = new Feed url: req.body.url
    user = new User id: req.user.sub

    feed.save().then (newFeedModel) ->
      newFeedModel.subscribers().attach user
      res.json newFeedModel
    .catch (err) ->
      res.status(500).json error: message: 'Unknown problem saving feed.'
