UserService = App.Services.UserService

module.exports = class UserController

  get: (req, res) ->

    UserService.get req.user.sub, (err, statusCode, user) ->
      res.status(statusCode).json user

  getFeeds: (req, res) ->

    UserService.getFeeds req.user.sub, (err, statusCode, feeds) ->
      res.status(statusCode).json feeds: feeds

  getSubscription: (req, res) ->

    userId = req.user.sub
    subId = req.params.id

    UserService.getSubscription userId, subId, (err, subscription) ->
      res.json subscription
