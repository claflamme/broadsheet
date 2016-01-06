validator = require 'validator'
Feed = App.Models.Feed
User = App.Models.User
UserService = App.Services.UserService

module.exports = class SubscriptionController

  list: (req, res) ->

    UserService.getFeeds req.user.sub, (err, statusCode, feeds) ->
      res.status(statusCode).json feeds: feeds

  show: (req, res) ->

    userId = req.user.sub
    subId = req.params.id

    UserService.getSubscription userId, subId, (err, subscription) ->
      res.json subscription

  create: (req, res) ->

    { url } = req.body

    unless url
      return res.status(400).json error: message: 'The url param is required.'

    unless validator.isURL url
      return res.status(400).json error: message: 'Invalid URL.'

    feed = new Feed url: url
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

  delete: (req, res) ->

    id = parseInt req.params.id

    unless id
      return res.status(400).json error: message: 'No feed ID specified.'

    feed = new Feed id: id

    feed.fetch().then (foundFeed) ->

      if foundFeed?
        foundFeed.subscribers().fetch().then (subscribers) ->
          subscribers.detach(req.user.sub).then ->
            if subscribers.length is 0
              foundFeed.destroy()
            res.status(204).send()
      else
        res.status(404).json error: message: 'User not subscribed to that feed.'

    .catch (err) ->
      res.status(500).json error: message: 'Unknown problem querying feeds.'
