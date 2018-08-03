mongoose = require 'mongoose'
User = require './User'
Feed = require './Feed'

Schema = mongoose.Schema {
  customTitle:
    type: String
    default: null
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: 'User'
    required: true
  feed:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Feed'
    required: true
  index:
    type: Number
    default: null
}, timestamps: true

Schema.methods.userIs = (userId) ->
  @user.toString() is userId

# Feed object IDs must reference a valid feed document.
Schema.path('feed').validate (feedObjectId, respond) ->
  Feed.findById feedObjectId, (err, feed) ->
    respond (not err) and feed

# User object IDs must reference a valid user document.
Schema.path('user').validate (userObjectId, respond) ->
  User.findById userObjectId, (err, user) ->
    respond (not err) and user

module.exports = mongoose.model 'Subscription', Schema
