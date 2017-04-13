module.exports = (app) ->

  schema =

    nonce:
      type: String
      unique: true

    user:
      type: app.mongoose.Schema.Types.ObjectId
      ref: 'User'

  app.mongoose.Schema schema, timestamps: true
