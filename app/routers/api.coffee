UserController = App.Controllers.UserController
JWTController = App.Controllers.JWTController

module.exports = (router) ->

  router.post '/tokens', JWTController.create
