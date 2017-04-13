path = require 'path'
requireDir = require 'require-dir'

loadModels = (app, dir) ->
  models = requireDir dir

  for name, schema of models
    models[name] = app.mongoose.model name, schema(app)

  models

module.exports = (app) ->
  app.mongoose.set 'debug', app.config.db.debug

  paths = app.config.paths

  loadModels app, path.resolve(paths.root, paths.models)
