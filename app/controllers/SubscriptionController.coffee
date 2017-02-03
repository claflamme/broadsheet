async = require 'async'

saveDoc = (doc, callback) ->
  doc.save (err, savedDoc) ->
    callback()

module.exports = (app) ->

  { Subscription } = app.models

  # Returns a list of all subscriptions belonging to a user.
  list: (req, res) ->

    query = Subscription.find user: req.user.sub

    query.populate('feed').exec (err, subscriptions) ->
      res.json subscriptions

  # Returns the details for a single subscription.
  show: (req, res) ->

    query = Subscription.findById req.params.id

    query.populate('feed').exec (err, subscription) ->
      unless subscription
        return res.error 'RESOURCE_NOT_FOUND'
      res.json subscription

  # Subscribes the user to a feed, using the given feed ID.
  create: (req, res) ->

    unless req.body.feedId
      return res.error 'MISSING_REQUEST_BODY_PARAMS', 'feedId'

    data =
      user: req.user.sub
      feed: req.body.feedId

    Subscription.create data, (err, subscription) ->
      subscription.populate 'feed', (err, subscription) ->
        res.json subscription

  # Unsubscribes a user from a given feed.
  delete: (req, res) ->

    Subscription.findById req.params.id, (err, subscription) ->

      unless subscription
        return res.error 'RESOURCE_NOT_FOUND'

      unless subscription.userIs req.user.sub
        return res.error 'PERMISSION_DENIED'

      subscription.remove (err) ->
        if err
          return res.error 'UNKNOWN_ERROR'
        res.json message: 'Unsubscribed'

  # Updates a user's subscription to a given feed. For now, only used for
  # updating the custom title.
  update: (req, res) ->

    Subscription.findById req.params.id, (err, subscription) ->

      unless subscription
        return res.error 'RESOURCE_NOT_FOUND'

      unless subscription.userIs req.user.sub
        return res.error 'PERMISSION_DENIED'

      if req.body.customTitle
        subscription.customTitle = req.body.customTitle

      subscription.save (err, updatedSubscription) ->
        res.json updatedSubscription

  updateMany: (req, res) ->

    documentMap = {}

    req.body.subscriptions.forEach (sub) ->
      documentMap[sub._id] = sub

    query =
      user: req.user.sub
      _id: { $in: Object.keys(documentMap) }

    Subscription.find query, (err, docs) ->

      updatedDocs = docs.map (doc) ->
        Object.assign doc, documentMap[doc._id]

      async.each updatedDocs, saveDoc, (err) ->
        res.json { hooray: 'saved!' }
