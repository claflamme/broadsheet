/* globals App */

const schema = {

  title: String,

  url: {
    type: String,
    unique: true
  },

  summary: String,

  publishedAt: Date,

  feed: {
    type: App.Mongoose.Schema.Types.ObjectId,
    ref: 'Feed'
  }

};

const Schema = App.Mongoose.Schema(schema);

module.exports = Schema;
