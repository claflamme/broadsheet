User = App.Models.User
Feed = App.Models.Feed

module.exports =

  show: (userId, subId, cb) ->

    user = new User id: userId

    user.subscription(subId).fetchOne().then (subscription) ->

      unless subscription
        return cb 'SUBSCRIPTION_NOT_FOUND'

      subscription.articles().fetch().then (articles) ->
        subscription = subscription.serialize()
        subscription.articles = articles.serialize()
        cb null, subscription

  list: (userId, callback) ->

    user = new User id: userId

    user.subscriptions().fetch().then (subscriptions) ->
      callback null, subscription.serialize()
    .catch (err) ->
      callback 'SUBSCRIPTION_UNKNOWN_ERROR'

  create: (userId, feedUrl, cb) ->

    feed = new Feed url: feedUrl
    user = new User id: userId

    feed.fetch().then (foundFeed) ->

      if foundFeed
        foundFeed.subscribers(req.user.sub).fetch().then (subscribers) ->
          unless subscribers.length is 0
            return cb null, foundFeed
          foundFeed.subscribers().attach(user).then ->
            return cb null, foundFeed
      else
        feed.save().then (newFeed) ->
          newFeed.subscribers().attach(user).then ->
            return cb null, newFeed

    .catch (err) ->

      console.log err

      cb 'FEED_UNKNOWN_ERROR'
