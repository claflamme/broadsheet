UserController = App.Controllers.UserController
AuthController = App.Controllers.AuthController

module.exports = (router) ->

  router.post '/tokens', AuthController.create
