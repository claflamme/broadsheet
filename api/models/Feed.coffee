moment = require 'moment'

# --- Schema -------------------------------------------------------------------

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

Schema = App.Mongoose.Schema schema, timestamps: true

# --- Helpers ------------------------------------------------------------------

getOutdatedThreshold = ->
  moment().utc().subtract App.Config.crawler.outdatedThreshold, 'minutes'

# --- Methods ------------------------------------------------------------------

# Returns a collection of all feeds that should be re-indexed.
Schema.statics.findOutdated = (cb) ->
  @where 'updatedAt'
  .lt getOutdatedThreshold()
  .exec cb

# Returns the single most outdated feed.
Schema.statics.findMostOutdated = (cb) ->
  query = updatedAt: $lt: getOutdatedThreshold()
  @findOne query, cb

module.exports = Schema
