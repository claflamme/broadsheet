requireDir = require 'require-dir'

models = requireDir App.Config.paths.models

for name, model of models
  models[name] = App.Bookshelf.Model.extend model
  App.Bookshelf.model name, models[name]

module.exports = models
