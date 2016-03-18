User = App.Models.User
Feed = App.Models.Feed
Article = App.Models.Article
Subscription = App.Models.Subscription

attachAndFetch = (user, feed, cb) ->

  user.subscriptions().attach(feed).then ->
    user.subscriptions(feed.get('id')).fetchOne().then (subscription) ->
      cb null, subscription

module.exports =

  show: (userId, feedIds, opts, cb) ->

    user = new User id: userId

    user.subscriptions(feedIds).fetch().then (subscriptions) ->

      unless subscriptions and subscriptions.length > 0
        return cb 'SUBSCRIPTION_NOT_FOUND'

      validFeedIds = subscriptions.serialize().map (subscription) ->
        subscription.id

      articles = Article.forge().query (query) ->
        query.where 'feed_id', 'in', validFeedIds
        .offset opts.offset or 0
        .limit opts.limit or 20
        .orderBy 'published_at', 'desc'

      articles.fetchAll().then (articles) ->
        cb null, { subscriptions, articles }

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
