moment = require 'moment'

getThreshold = ->

  moment().utc().subtract 10, 'minutes'

module.exports =

  tableName: 'feeds'
  hasTimestamps: true

  subscribers: ->

    @belongsToMany 'User'

  articles: ->

    @hasMany 'Article'

  outdated: ->

    @where 'updated_at', '<', getThreshold()

  oldest: ->

    @query (queryBuilder) ->
      queryBuilder
      .where 'updated_at', '<', getThreshold()
      .orderBy 'updated_at', 'asc'
