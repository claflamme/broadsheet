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

    userId = req.user.sub

    SubscriptionService.list req.user.sub, (err, subscriptions) ->
      if err
        res.error err
      else
        res.json subscriptions

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
      if err
        res.error err
      else
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

    url = req.body.url
    userId = req.user.sub

    unless url
      return res.error 'SUBSCRIPTION_URL_REQUIRED'

    unless validator.isURL url
      return res.error 'SUBSCRIPTION_URL_INVALID'

    SubscriptionService.create req.user.sub, url, (err, subscription) ->
      if err
        res.error err
      else
        res.json subscription

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
      user.subscriptions(feedId).fetchOne().then (feed) ->
        res.json feed.serialize()
