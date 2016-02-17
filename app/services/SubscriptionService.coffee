User = App.Models.User

module.exports =

  show: (userId, subId, cb) ->

    user = new User id: userId

    user.subscription(subId).fetchOne().then (subscription) ->
      cleaned = subscription.serialize omitPivot: true
      cleaned.custom_name = subscription.pivot.get 'custom_name'
      cb null, cleaned

  list: (userId, callback) ->

    user = new User id: userId

    user.feeds().fetch().then (feeds) ->
      callback null, 200, feeds.serialize omitPivot: true
    .catch (err) ->
      callback err, 500, null
