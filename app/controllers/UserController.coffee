UserService = App.Services.UserService

module.exports = class UserController

  get: (req, res) ->

    UserService.get req.user.sub, (err, statusCode, user) ->
      res.status(statusCode).json user
