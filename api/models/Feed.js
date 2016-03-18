const moment = require('moment');

/* globals App */

// --- Helpers -----------------------------------------------------------------

function getOutdatedThreshold () {
  return moment().utc().subtract(10, 'minutes');
}

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

Schema.statics.findOutdated = function (cb) {
  this.where('updatedAt').lt(getOutdatedThreshold()).exec(cb);
};

Schema.statics.findMostOutdated = function (cb) {
  const query = {
    updatedAt: {
      $lt: getOutdatedThreshold()
    }
  };
  this.findOne(query, cb);
};

module.exports = Schema;
