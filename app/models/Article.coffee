mongoosePaginate = require 'mongoose-paginate'

module.exports = (app) ->

  schema =

    title: String

    url:
      type: String
      unique: true

    summary: String
    publishedAt: Date

    feed:
      type: app.mongoose.Schema.Types.ObjectId
      ref: 'Feed'

  Schema = app.mongoose.Schema schema

  Schema.plugin mongoosePaginate

  return Schema
