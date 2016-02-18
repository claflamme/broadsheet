User = App.Models.User

module.exports =

  show: (userId, subId, cb) ->

    user = new User id: userId

    user.subscription(subId).fetchOne().then (subscription) ->
      subscription.articles().fetch().then (articles) ->
        subscription = subscription.serialize()
        subscription.articles = articles.serialize()
        cb null, subscription

  list: (userId, callback) ->

    user = new User id: userId

    user.subscriptions().fetch().then (feeds) ->
      callback null, 200, feeds.serialize()
    .catch (err) ->
      callback err, 500, null
