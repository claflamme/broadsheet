UserService = App.Services.UserService

module.exports =

  get: (req, res) ->

    UserService.get req.user.sub, (err, statusCode, user) ->
      res.status(statusCode).json user
