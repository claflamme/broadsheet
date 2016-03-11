moment = require 'moment'

getThreshold = ->

  moment().utc().subtract 10, 'minutes'

module.exports =

  tableName: 'feeds'
  hasTimestamps: true

  subscribers: (subscriberId) ->

    subscribers = @belongsToMany 'User', 'subscriptions'

    if subscriberId
      subscribers = subscribers.query 'where', 'id', '=', subscriberId

    return subscribers

  articles: ->

    @hasMany 'Article'

  outdated: ->

    @query (queryBuilder) ->
      queryBuilder
      .whereRaw 'updated_at = created_at'
      .orWhere 'updated_at', null
      .orWhere 'updated_at', '<', getThreshold()
      .orderBy 'updated_at', 'asc'
