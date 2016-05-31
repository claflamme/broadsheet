path = require 'path'
requireDir = require 'require-dir'

module.exports = (app) ->

  paths = app.config.paths
  controllersPath = path.resolve paths.root, paths.controllers

  controllers = requireDir controllersPath

  for name, controller of controllers
    controllers[name] = controller(app)

  controllers
