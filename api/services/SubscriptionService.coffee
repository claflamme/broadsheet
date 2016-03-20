User = App.Models.User
Feed = App.Models.Feed
Article = App.Models.Article
Subscription = App.Models.Subscription

module.exports =

  show: (userId, subId, cb) ->

    Subscription
    .findById subId
    .populate 'feed'
    .exec (err, subscription) ->

      unless subscription
        return cb 'SUBSCRIPTION_NOT_FOUND'

      cb null, subscription

  create: (userId, feedId, cb) ->

    data = user: userId, feed: feedId

    Subscription.create data, (err, subscription) ->

      if err
        console.log err
        return

      subscription.populate 'feed', (err, subscription) ->
        cb null, subscription
