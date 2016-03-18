requireDir = require 'require-dir'

App.Mongoose.connect process.env.DATABASE_URL

models = requireDir App.Config.paths.models

for name, schema of models
  models[name] = App.Mongoose.model name, schema(App.Mongoose)

module.exports = models
