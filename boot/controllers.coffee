requireDir = require 'require-dir'

controllers = requireDir App.Config.paths.controllers

# Since controller methods are invoked as a callback via Express' router, the
# contexts of the methods are set to the global module scope. E.g., calling `@`
# inside of a controller method would give you access to `@.process.env`.
#
# This script binds all of the controller's methods to the controller context.

bindProps = (loadedModule) ->

  Object.keys(loadedModule).forEach (prop) ->
    unless typeof loadedModule[prop] is 'function'
      return
    loadedModule[prop] = loadedModule[prop].bind loadedModule

  return loadedModule

for i, controller of controllers

  controller.prototype = bindProps controller.prototype
  controller = bindProps controller

  controllers[i] = new controller

module.exports = controllers
