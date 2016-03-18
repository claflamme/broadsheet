moment = require 'moment'

getThreshold = ->

  moment().utc().subtract 10, 'minutes'

module.exports = (mongoose) ->

  mongoose.Schema

    title: String
    description: String
    url: String
    created_at:
      type: Date
      default: Date.now
    updated_at:
      type: Date
      default: Date.now

# module.exports =
#
#   subscribers: (subscriberId) ->
#
#     subscribers = @belongsToMany 'User', 'subscriptions'
#
#     if subscriberId
#       subscribers = subscribers.query 'where', 'id', '=', subscriberId
#
#     return subscribers
#
#   articles: ->
#
#     @hasMany 'Article'
#
#   outdated: ->
#
#     @query (queryBuilder) ->
#       queryBuilder
#       .whereRaw 'updated_at = created_at'
#       .orWhere 'updated_at', null
#       .orWhere 'updated_at', '<', getThreshold()
#       .orderBy 'updated_at', 'asc'
