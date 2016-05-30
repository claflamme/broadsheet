path = require 'path'
requireDir = require 'require-dir'

paths = App.Config.paths
controllersPath = path.resolve paths.root, paths.controllers

module.exports = requireDir controllersPath
