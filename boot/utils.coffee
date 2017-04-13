path = require 'path'

module.exports = (app) ->

  getPath: (relativePath) ->

    path.resolve app.config.paths.root, relativePath
