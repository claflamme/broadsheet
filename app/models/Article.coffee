mongoosePaginate = require 'mongoose-paginate'

module.exports = (app) ->

  # --- Schema -----------------------------------------------------------------

  schema =

    title: String

    url:
      type: String
      unique: true

    summary: String

    body:
      type: String
      default: null

    publishedAt: Date

    feed:
      type: app.mongoose.Schema.Types.ObjectId
      ref: 'Feed'

  Schema = app.mongoose.Schema schema, timestamps: true

  # --- Plugins ----------------------------------------------------------------

  Schema.plugin mongoosePaginate

  return Schema
