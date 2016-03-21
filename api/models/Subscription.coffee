# --- Schema -------------------------------------------------------------------

schema =

  customTitle:
    type: String
    default: null

  user:
    type: App.Mongoose.Schema.Types.ObjectId
    ref: 'User'
    required: true

  feed:
    type: App.Mongoose.Schema.Types.ObjectId
    ref: 'Feed'
    required: true

Schema = App.Mongoose.Schema schema, timestamps: true

# --- Methods ------------------------------------------------------------------

Schema.methods.userIs = (userId) ->
  @user.toString() is userId

# --- Validators ---------------------------------------------------------------

# Feed object IDs must reference a valid feed document.
Schema.path('feed').validate (feedObjectId, respond) ->
  App.Models.Feed.findById feedObjectId, (err, feed) ->
    respond (not err) and feed

# User object IDs must reference a valid user document.
Schema.path('user').validate (userObjectId, respond) ->
  App.Models.User.findById userObjectId, (err, user) ->
    respond (not err) and user

module.exports = Schema
