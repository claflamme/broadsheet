moment = require 'moment'
mongoose = require 'mongoose'
config = require '../../config'

Schema = mongoose.Schema {
  title:
    type: String
    default: null
  description:
    type: String
    default: null
  url:
    type: String
    unique: true
  iconUrl:
    type: String
}, timestamps: true

getOutdatedThreshold = ->
  moment().utc().subtract config.crawler.outdatedThreshold, 'minutes'

# Returns a collection of all feeds that should be re-indexed.
Schema.statics.findOutdated = (cb) ->
  @where 'updatedAt'
  .lt getOutdatedThreshold()
  .exec cb

# Returns the single most outdated feed.
Schema.statics.findMostOutdated = (cb) ->
  query = updatedAt: $lt: getOutdatedThreshold()
  @findOne query, cb

module.exports = mongoose.model 'Feed', Schema
