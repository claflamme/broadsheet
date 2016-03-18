/* globals App */

const schema = {

  title: String,
  url: String,
  description: String,
  summary: String,
  published_at: Date

};

const Schema = App.Mongoose.Schema(schema);

module.exports = Schema;
