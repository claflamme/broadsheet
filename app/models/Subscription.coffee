module.exports = (app) ->

  # --- Schema -----------------------------------------------------------------

  schema =

    customTitle:
      type: String
      default: null

    user:
      type: app.mongoose.Schema.Types.ObjectId
      ref: 'User'
      required: true

    feed:
      type: app.mongoose.Schema.Types.ObjectId
      ref: 'Feed'
      required: true

    index:
      type: Number
      default: null

  Schema = app.mongoose.Schema schema, timestamps: true

  # --- Methods ----------------------------------------------------------------

  Schema.methods.userIs = (userId) ->
    @user.toString() is userId

  # --- Validators -------------------------------------------------------------

  # Feed object IDs must reference a valid feed document.
  Schema.path('feed').validate (feedObjectId, respond) ->
    app.models.Feed.findById feedObjectId, (err, feed) ->
      respond (not err) and feed

  # User object IDs must reference a valid user document.
  Schema.path('user').validate (userObjectId, respond) ->
    app.models.User.findById userObjectId, (err, user) ->
      respond (not err) and user

  return Schema
