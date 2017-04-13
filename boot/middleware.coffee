bodyParser = require 'body-parser'
jwt = require 'express-jwt'
stylus = require 'stylus'
morgan = require 'morgan'
browserifyMiddleware = require 'browserify-middleware'
stylusBootstrap = require 'bootstrap-styl'
express = require 'express'

loadStylusMiddleware = (app) ->

  app.express.use stylus.middleware
    src: app.utils.getPath app.config.stylus.inputPath
    dest: app.utils.getPath app.config.paths.public
    compile: (str, path) ->
      stylus str
      .set 'compress', app.config.stylus.compress
      .set 'filename', path
      .use stylusBootstrap()

loadBrowserifyMiddleware = (app) ->

  app.config.browserify.forEach (config) ->
    input = app.utils.getPath config.inputPath
    output = "/#{ config.outputPath }"
    app.express.get output, browserifyMiddleware input, config.options

loadRouterMiddleware = (app) ->

  router = express.Router()
  userRoutesPath = app.utils.getPath app.config.paths.routes + '/router'

  app.express.use require(userRoutesPath) app, router

loadAuthMiddleware = (app) ->

  unprotected = app.utils.getPath "#{ app.config.paths.routes }/unprotected"
  jwtOpts = secret: process.env.JWT_SECRET
  auth = jwt(jwtOpts).unless path: require(unprotected)

  app.express.use '/api', auth

loadErrorMiddleware = (app) ->

  app.express.use (err, req, res, next) ->
    if err.name is 'UnauthorizedError'
      res.status(401).json error: message: 'Invalid auth token.'
    else
      res.status(500).json error: message: 'Unexpected error.'
      console.error err

  app.express.use require('./errors') app

module.exports = (app) ->

  unless process.env.NODE_ENV is 'production'
    app.express.use morgan 'dev'

  app.express.use bodyParser.json()
  loadStylusMiddleware app
  loadBrowserifyMiddleware app
  app.express.use express.static 'public'
  loadAuthMiddleware app
  loadErrorMiddleware app
  loadRouterMiddleware app
