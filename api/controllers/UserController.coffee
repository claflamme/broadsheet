UserService = App.Services.UserService

module.exports =

  ###
  @apiGroup User
  @api { get } /api/user Details
  @apiDescription Returns the model for the current user.
  ###
  get: (req, res) ->

    UserService.get req.user.sub, (err, statusCode, user) ->
      res.status(statusCode).json user
