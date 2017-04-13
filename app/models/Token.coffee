module.exports = (app) ->

  schema =

    jti: String

    iat: Number

    user:
      type: app.mongoose.Schema.Types.ObjectId
      ref: 'User'

  return app.mongoose.Schema schema
