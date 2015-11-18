requireDir = require 'require-dir'
traverse = require 'traverse'

controllers = requireDir App.Config.paths.controllers, recurse: true

traverse(controllers).forEach (controller) ->

  unless @isLeaf
    return

  @update new controller()

module.exports = controllers
