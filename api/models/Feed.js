const moment = require('moment');

/* globals App */

// --- Schema ------------------------------------------------------------------

const schema = {

  title: {
    type: String,
    default: null
  },

  description: {
    type: String,
    default: null
  },

  url: {
    type: String,
    unique: true
  }

};

const Schema = App.Mongoose.Schema(schema, { timestamps: true });

// --- Methods -----------------------------------------------------------------

Schema.statics.findOutdated = function(cb) {

  const query = {
    updatedAt: {
      $lt: moment().utc().subtract(10, 'minutes')
    }
  };

  this.find(query, cb);

};

module.exports = Schema;

// # module.exports =
// #
// #   subscribers: (subscriberId) ->
// #
// #     subscribers = @belongsToMany 'User', 'subscriptions'
// #
// #     if subscriberId
// #       subscribers = subscribers.query 'where', 'id', '=', subscriberId
// #
// #     return subscribers
// #
// #   articles: ->
// #
// #     @hasMany 'Article'
// #
// #   outdated: ->
// #
// #     @query (queryBuilder) ->
// #       queryBuilder
// #       .whereRaw 'updated_at = created_at'
// #       .orWhere 'updated_at', null
// #       .orWhere 'updated_at', '<', getThreshold()
// #       .orderBy 'updated_at', 'asc'
