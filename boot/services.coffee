path = require 'path'
requireDir = require 'require-dir'


module.exports = (app) ->

  paths = app.config.paths
  services = requireDir path.resolve paths.root, paths.services

  for name, service of services
    services[name] = service app

  services
