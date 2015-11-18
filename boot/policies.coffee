requireDir = require 'require-dir'
traverse = require 'traverse'

policies = requireDir App.Config.paths.policies, recurse: true

traverse(policies).forEach (policy) ->

  unless @isLeaf
    return

  @update new policy().check

module.exports = policies
