path = require 'path'
requireDir = require 'require-dir'

loadControllers = (app, path) ->

  controllers = requireDir path

  for name, controller of controllers
    controllers[name] = controller app

  controllers

mergeModules = (bundledModules, userModules) ->

  Object.keys(userModules).forEach (key) ->
    if bundledModules[key]
      console.error "\nGunpowder already provides a module named '#{ key }'."
      console.error "Please rename your module.\n"
      process.exit 1

  Object.assign {}, bundledModules, userModules

module.exports = (app) ->

  paths = app.config.paths

  userControllersPath = path.resolve paths.root, paths.controllers
  loadControllers app, userControllersPath
