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

  this.find(query).sort('updatedAt').exec(cb);

};

module.exports = Schema;
