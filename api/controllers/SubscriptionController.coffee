validator = require 'validator'
Feed = App.Models.Feed
User = App.Models.User
SubscriptionService = App.Services.SubscriptionService

module.exports =

  ###
  @apiGroup Subscriptions

  @api { get } /api/subscriptions List

  @apiDescription
    Returns a list of all subscriptions a user has.
  ###
  list: (req, res) ->

    SubscriptionService.list req.user.sub, (err, statusCode, feeds) ->
      res.status(statusCode).json feeds

  ###
  @apiGroup Subscriptions

  @api { get } /api/subscriptions/:id Articles

  @apiDescription
    Returns a single subscription and all of its articles.
  ###
  show: (req, res) ->

    userId = req.user.sub
    subId = req.params.id

    SubscriptionService.show userId, subId, (err, subscription) ->
      res.json subscription

  ###
  @apiGroup Subscriptions

  @api { post } /api/subscriptions/ Subscribe
  @apiParam { String } url A URL to an RSS feed.

  @apiDescription
    Adds a new subscription to the user's account and returns its details. If
    the feed URL is not in the system, it will be added.
  ###
  create: (req, res) ->

    { url } = req.body

    unless url
      return res.status(400).json error: message: 'The url param is required.'

    unless validator.isURL url
      return res.status(400).json error: message: 'Invalid URL.'

    feed = new Feed url: url
    user = new User id: req.user.sub

    feed.fetch().then (foundFeed) ->

      if foundFeed
        foundFeed.subscribers(req.user.sub).fetch().then (subscribers) ->
          unless subscribers.length is 0
            return res.json foundFeed
          foundFeed.subscribers().attach(user).then ->
            res.json foundFeed
      else
        feed.save().then (newFeed) ->
          newFeed.subscribers().attach(user).then ->
            res.json newFeed

    .catch (err) ->
      res.status(500).json error: message: 'Unknown problem querying feeds.'

  ###
  @apiGroup Subscriptions

  @api { delete } /api/subscriptions/:id Unsubscribe

  @apiDescription
    Unsubscribes a user from a given feed. If no more subscribers are left, the
    feed will be removed from the system.
  ###
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

  ###
  @apiGroup Subscriptions

  @api { patch } /api/subscriptions/:id Update
  @apiParam { String } custom_title The name to display the feed as to the user.

  @apiDescription
    Updates a user's subscription. This does **not** update the feed for every
    user, it just updates pivot data for the current user.
  ###
  update: (req, res) ->

    feedId = parseInt req.params.id
    userId = req.user.sub
    user = new User id: userId

    fields =
      custom_title: req.body.custom_title

    user.updateSubscription(feedId, fields).then ->
      user.subscription(feedId).fetch().then (feed) ->
        res.json feed.serialize()
