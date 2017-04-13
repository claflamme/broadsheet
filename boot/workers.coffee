path = require 'path'
requireDir = require 'require-dir'

module.exports = (app) ->

  paths = app.config.paths
  workers = requireDir path.resolve paths.root, paths.workers

  for name, worker of workers
    workers[name] = worker app

  workers
