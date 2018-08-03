mongoose = require 'mongoose'
mongoosePaginate = require 'mongoose-paginate'

schema =
  title: String
  url: String
  summary: String
  author: String
  body:
    type: String
    default: null
  publishedAt: Date
  feed:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Feed'

Schema = mongoose.Schema schema, timestamps: true
Schema.plugin mongoosePaginate

module.exports = mongoose.model 'Article', Schema
