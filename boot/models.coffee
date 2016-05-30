requireDir = require 'require-dir'
paginator = require 'mongoose-paginate'

# Some global defaults for pagination
paginator.paginate.options =
  limit: 50

App.Mongoose.set 'debug', App.Config.db.debug

models = requireDir App.Config.paths.models

for name, schema of models
  models[name] = App.Mongoose.model name, schema

module.exports = models
