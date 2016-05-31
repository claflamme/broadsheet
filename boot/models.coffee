path = require 'path'
requireDir = require 'require-dir'
paginator = require 'mongoose-paginate'

# Some global defaults for pagination
paginator.paginate.options =
  limit: 50

module.exports = (app) ->

  app.mongoose.set 'debug', app.config.db.debug

  models = requireDir path.resolve app.config.paths.root, app.config.paths.models

  for name, schema of models
    models[name] = app.mongoose.model name, schema(app)

  models
