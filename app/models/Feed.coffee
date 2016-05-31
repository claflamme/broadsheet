moment = require 'moment'

module.exports = (app) ->

  # --- Schema -----------------------------------------------------------------

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

    iconUrl:
      type: String

  Schema = app.mongoose.Schema schema, timestamps: true

  # --- Helpers ----------------------------------------------------------------

  getOutdatedThreshold = ->
    moment().utc().subtract app.config.crawler.outdatedThreshold, 'minutes'

  # --- Methods ----------------------------------------------------------------

  # Returns a collection of all feeds that should be re-indexed.
  Schema.statics.findOutdated = (cb) ->
    @where 'updatedAt'
    .lt getOutdatedThreshold()
    .exec cb

  # Returns the single most outdated feed.
  Schema.statics.findMostOutdated = (cb) ->
    query = updatedAt: $lt: getOutdatedThreshold()
    @findOne query, cb

  return Schema
