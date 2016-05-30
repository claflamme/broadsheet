path = require 'path'
requireDir = require 'require-dir'

paths = App.Config.paths

module.exports = requireDir path.resolve paths.root, paths.services
