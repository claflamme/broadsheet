User = App.Models.User
Feed = App.Models.Feed

attachAndFetch = (user, feed, cb) ->

  user.subscriptions().attach(feed).then ->
    user.subscriptions(feed.get('id')).fetchOne().then (subscription) ->
      cb null, subscription

module.exports =

  show: (userId, subId, cb) ->

    user = new User id: userId

    user.subscriptions(subId).fetchOne().then (subscription) ->

      unless subscription
        return cb 'SUBSCRIPTION_NOT_FOUND'

      subscription.articles().fetch().then (articles) ->
        subscription = subscription.serialize()
        subscription.articles = articles.serialize()
        cb null, subscription

  list: (userId, callback) ->

    user = new User id: userId

    user.subscriptions().fetch().then (subscriptions) ->
      callback null, subscriptions.serialize()
    .catch (err) ->
      callback 'SUBSCRIPTION_UNKNOWN_ERROR'

  create: (userId, feedUrl, cb) ->

    feed = new Feed url: feedUrl
    user = new User id: userId

    feed.fetch().then (foundFeed) ->

      unless foundFeed
        return feed.save().then (newFeed) ->
          attachAndFetch user, newFeed, cb

      foundFeedId = foundFeed.get 'id'

      user.subscriptions(foundFeedId).fetchOne().then (subscription) ->
        if subscription
          return cb null, subscription
        attachAndFetch user, foundFeed, cb

    .catch (err) ->

      console.log err

      cb 'FEED_UNKNOWN_ERROR'
