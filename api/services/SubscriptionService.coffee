User = App.Models.User
Feed = App.Models.Feed
Article = App.Models.Article

attachAndFetch = (user, feed, cb) ->

  user.subscriptions().attach(feed).then ->
    user.subscriptions(feed.get('id')).fetchOne().then (subscription) ->
      cb null, subscription

module.exports =

  show: (userId, feedIds, cb) ->

    user = new User id: userId

    user.subscriptions(feedIds).fetch().then (subscriptions) ->

      unless subscriptions and subscriptions.length > 0
        return cb 'SUBSCRIPTION_NOT_FOUND'

      validFeedIds = subscriptions.serialize().map (subscription) ->
        subscription.id

      articles = Article.forge().query (query) ->
        query.where 'feed_id', 'in', validFeedIds
        .orderBy 'published_at', 'desc'

      articles.fetchAll().then (articles) ->
        cb null, subscriptions, articles

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
