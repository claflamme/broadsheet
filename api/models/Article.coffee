bcrypt = require 'bcryptjs'

module.exports =

  tableName: 'articles'
  hasTimestamps: true

  feed: ->

    @belongsTo 'Feed'
