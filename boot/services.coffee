path = require 'path'
requireDir = require 'require-dir'

loadServices = (app, dir) ->

  services = requireDir dir

  for name, service of services
    services[name] = service app

  services

module.exports = (app) ->

  paths = app.config.paths

  userServicesDir = path.resolve paths.root, paths.services
  loadServices app, userServicesDir
