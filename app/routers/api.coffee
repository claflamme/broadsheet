AuthController = App.Controllers.AuthController

module.exports = (router) ->

  router.post '/authenticate', AuthController.authenticate
