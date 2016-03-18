moment = require 'moment'

getThreshold = ->

  moment().utc().subtract 10, 'minutes'

module.exports = (mongoose) ->

  schema =

    title:
      type: String
      default: null

    description:
      type: String
      default: null

    url:
      type: String
      unique: true

  Schema = mongoose.Schema schema, { timestamps: true }

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
