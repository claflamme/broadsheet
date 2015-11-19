requireDir = require 'require-dir'

models = requireDir App.Config.paths.models

for i, model of models
  models[i] = App.Bookshelf.Model.extend model

module.exports = models
