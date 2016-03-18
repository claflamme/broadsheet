moment = require 'moment'

module.exports = (mongoose) ->

  getOutdatedThreshold = ->

    moment().utc().subtract 10, 'minutes'

  # --- Schema -----------------------------------------------------------------

  schema =

    customTitle:
      type: String
      default: null

    user:
      type: mongoose.Schema.Types.ObjectId
      ref: 'User'

    feed:
      type: mongoose.Schema.Types.ObjectId
      ref: 'Feed'

  Schema = mongoose.Schema schema, { timestamps: true }

  # --- Validators -------------------------------------------------------------

  # Feed object IDs must reference a valid feed document.
  Schema.path('feed').validate (feedObjectId, respond) ->
    App.Models.Feed.findOne _id: feedObjectId, (err, feed) ->
      respond (not err) and feed

  # User object IDs must reference a valid user document.
  Schema.path('user').validate (userObjectId, respond) ->
    App.Models.User.findOne _id: userObjectId, (err, user) ->
      respond (not err) and user

  module.exports = Schema
