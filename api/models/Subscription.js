/* globals App */

// --- Schema ------------------------------------------------------------------

const schema = {

  customTitle: {
    type: String,
    default: null
  },

  user: {
    type: App.Mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },

  feed: {
    type: App.Mongoose.Schema.Types.ObjectId,
    ref: 'Feed'
  }

};

const Schema = App.Mongoose.Schema(schema, { timestamps: true });

// --- Validators --------------------------------------------------------------

// Feed object IDs must reference a valid feed document.
Schema.path('feed').validate((feedObjectId, respond) => {
  App.Models.Feed.findById(feedObjectId, (err, feed) => {
    respond((!err) && feed);
  });
});

// User object IDs must reference a valid user document.
Schema.path('user').validate((userObjectId, respond) => {
  App.Models.User.findById(userObjectId, (err, user) => {
    respond((!err) && user);
  });
});

module.exports = Schema;
