User = App.Models.User
Feed = App.Models.Feed
Article = App.Models.Article
Subscription = App.Models.Subscription

attachAndFetch = (user, feed, cb) ->

  user.subscriptions().attach(feed).then ->
    user.subscriptions(feed.get('id')).fetchOne().then (subscription) ->
      cb null, subscription

module.exports =

  show: (userId, subId, cb) ->

    Subscription
    .findById subId
    .populate 'feed'
    .exec (err, subscription) ->

      unless subscription
        return cb 'SUBSCRIPTION_NOT_FOUND'

      cb null, subscription

  list: (userId, callback) ->

    user = new User id: userId

    user.subscriptions().fetch().then (subscriptions) ->
      callback null, subscriptions.serialize()
    .catch (err) ->
      callback 'SUBSCRIPTION_UNKNOWN_ERROR'

  create: (userId, feedId, cb) ->

    data = user: userId, feed: feedId

    Subscription.create data, (err, subscription) ->

      if err
        console.log err
        return

      subscription.populate 'feed', (err, subscription) ->
        cb null, subscription
