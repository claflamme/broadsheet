path = require 'path'
requireDir = require 'require-dir'

loadHelpers = (app, dir) ->

  helpers = requireDir dir

  for name, helper of helpers
    helpers[name] = helper app

  helpers

module.exports = (app) ->
  paths = app.config.paths

  userHelpersDir = path.resolve paths.root, paths.helpers

  loadHelpers app, userHelpersDir
