bcrypt = require 'bcryptjs'

module.exports = (app) ->

  schema =

    email:
      type: String
      unique: true

    password:
      type: String
      set: app.helpers.AuthHelper.createHash

  Schema = app.mongoose.Schema schema, timestamps: true

  return Schema
