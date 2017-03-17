module.exports = (app) ->

  schema =

    email:
      type: String
      unique: true

  Schema = app.mongoose.Schema schema, timestamps: true

  return Schema
