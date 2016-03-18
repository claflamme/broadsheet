requireDir = require 'require-dir'

App.Mongoose.set 'debug', true
App.Mongoose.connect process.env.DATABASE_URL

models = requireDir App.Config.paths.models

for name, schema of models
  models[name] = App.Mongoose.model name, schema

module.exports = models
