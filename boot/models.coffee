requireDir = require 'require-dir'
traverse = require 'traverse'
mongoose = require 'mongoose'

models = requireDir App.Config.paths.models, recurse: true

traverse(models).forEach (model) ->

  unless @isLeaf
    return

  @update model mongoose

module.exports = models
