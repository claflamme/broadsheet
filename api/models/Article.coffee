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

module.exports = App.Mongoose.Schema schema
