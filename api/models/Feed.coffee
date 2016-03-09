moment = require 'moment'

getThreshold = ->

  moment().utc().subtract 10, 'minutes'

module.exports =

  tableName: 'feeds'
  hasTimestamps: true

  subscribers: ->

    @belongsToMany 'User', 'subscriptions'

  articles: ->

    @hasMany 'Article'

  outdated: ->

    @query (queryBuilder) ->
      queryBuilder
      .whereRaw 'updated_at = created_at'
      .orWhere 'updated_at', null
      .orWhere 'updated_at', '<', getThreshold()
      .orderBy 'updated_at', 'asc'
