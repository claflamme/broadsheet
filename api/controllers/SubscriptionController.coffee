validator = require 'validator'
Feed = App.Models.Feed
User = App.Models.User
Subscription = App.Models.Subscription

module.exports =

  ###
  @apiGroup Subscriptions
  @api { get } /api/subscriptions List
  @apiDescription Returns a list of all subscriptions a user has.
  ###
  list: (req, res) ->

    userId = req.user.sub

    App.Models.Subscription
    .find user: userId
    .populate 'feed'
    .exec (err, subscriptions) ->
      res.json subscriptions

  ###
  @apiGroup Subscriptions
  @api { get } /api/subscriptions/:feedIds Articles
  @apiDescription
    Returns a list of articles belonging to one or more feeds that a user is
    subscribed to. The URL parameter `:feedIds` is a comma-separated list of
    feed IDs from which to return articles. If the user does not have a
    subscription for a provided feed ID, data for that feed will not be
    returned.
  ###
  show: (req, res) ->

    App.Models.Subscription
    .findById req.params.id
    .populate 'feed'
    .exec (err, subscription) ->

      unless subscription
        return res.error 'RESOURCE_NOT_FOUND'

      res.json subscription

  ###
  @apiGroup Subscriptions
  @api { post } /api/subscriptions/ Subscribe
  @apiDescription
    Adds a new subscription to the user's account and returns its details. If
    the feed URL is not in the system, it will be added.
  ###
  create: (req, res) ->

    feedId = req.body.feedId
    userId = req.user.sub
    data = user: userId, feed: feedId

    unless feedId
      return res.error 'MISSING_REQUEST_BODY_PARAMS', 'feedId'

    App.Models.Subscription.create data, (err, subscription) ->

      subscription.populate 'feed', (err, subscription) ->
      res.json subscription

  ###
  @apiGroup Subscriptions
  @api { delete } /api/subscriptions/:id Unsubscribe
  @apiDescription
    Unsubscribes a user from a given feed.
  ###
  delete: (req, res) ->

    subscriptionId = req.params.id
    userId = req.user.sub

    App.Models.Subscription.findById subscriptionId, (err, subscription) ->

      unless subscription
        return res.error 'RESOURCE_NOT_FOUND'

      if subscription.user.toString() isnt userId
        return res.error 'PERMISSION_DENIED'

      subscription.remove (err, subscription) ->
        res.status(204).send()

  ###
  @apiGroup Subscriptions
  @api { patch } /api/subscriptions/:id Update
  @apiParam { String } custom_title The name to display the feed as to the user.
  @apiDescription
    Updates a user's subscription to a given feed. This does **not** update the
    feed, it just updates pivot data for the current user.
  ###
  update: (req, res) ->

    subscriptionId = req.params.id
    userId = req.user.sub

    # Don't use findByIdAndUpdate(), since it doesn't trigger any schema
    # middleware, validators, or transformers.
    App.Models.Subscription
    .findById subscriptionId
    .exec (err, subscription) ->

      unless subscription
        return res.error 'RESOURCE_NOT_FOUND'

      if subscription.user.toString() isnt userId
        return res.error 'PERMISSION_DENIED'

      if req.body.customTitle
        subscription.customTitle = req.body.customTitle

      subscription.save (err, subscription) ->
        res.json subscription
