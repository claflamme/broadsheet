AuthController = App.Controllers.AuthController

module.exports = (router) ->

  router.get '/', (req, res) ->
    res.send 'hello'

  router.get '/auth', App.Policies.auth.isLoggedIn, (req, res) ->
    res.render 'dashboard'
