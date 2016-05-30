mongoosePaginate = require 'mongoose-paginate'

schema =

  title: String

  url:
    type: String
    unique: true

  summary: String
  publishedAt: Date

  feed:
    type: App.Mongoose.Schema.Types.ObjectId
    ref: 'Feed'

Schema = App.Mongoose.Schema schema

Schema.plugin mongoosePaginate

module.exports = Schema
