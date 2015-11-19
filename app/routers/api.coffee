UserController = App.Controllers.UserController
SessionController = App.Controllers.SessionController

module.exports = (router) ->

  router.get '/', (req, res) -> res.send 'api api api'
