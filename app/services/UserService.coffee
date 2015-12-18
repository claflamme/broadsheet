User = App.Models.User

module.exports = class AuthService

  get: (userId, callback) ->

    user = new User id: userId

    user.fetch().then (foundUser) ->
      statusCode = if foundUser then 200 else 404
      callback null, statusCode, foundUser
    .catch (err) ->
      callback err, 500, null

  getFeeds: (userId, callback) ->

    user = new User id: userId

    user.feeds().fetch().then (feeds) ->
      callback null, 200, feeds.serialize omitPivot: true
    .catch (err) ->
      callback err, 500, null
