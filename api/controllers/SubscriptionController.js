/* globals App */

const Subscription = App.Models.Subscription;

module.exports = {

  /**
   * @apiGroup Subscriptions
   * @api { get } /api/subscriptions List
   * @apiDescription Returns a list of all subscriptions belonging to a user.
   */
  list: function (req, res) {

    const query = Subscription.find({ user: req.user.sub });

    query.populate('feed').exec((err, subscriptions) => {
      res.json(subscriptions);
    });

  },

  /**
   * @apiGroup Subscriptions
   * @api { get } /api/subscriptions/:id Details
   * @apiDescription Returns the details for a single subscription.
   */
  show: function (req, res) {

    const query = Subscription.findById(req.params.id);

    query.populate('feed').exec((err, subscription) => {
      if (!subscription) {
        return res.error('RESOURCE_NOT_FOUND');
      }
      res.json(subscription);
    });

  },

  /**
   * @apiGroup Subscriptions
   * @api { post } /api/subscriptions/ Subscribe
   * @apiParam { ObjectID } feedId ObjectID of a feed.
   * @apiDescription Subscribes the user to a feed, using the given feed ID.
   */
  create: function (req, res) {

    if (!req.body.feedId) {
      return res.error('MISSING_REQUEST_BODY_PARAMS', 'feedId');
    }

    const data = {
      user: req.user.sub,
      feed: req.body.feedId
    };

    Subscription.create(data, (err, subscription) => {
      subscription.populate('feed', (err, subscription) => {
        res.json(subscription);
      });
    });

  },

  /**
   * @apiGroup Subscriptions
   * @api { delete } /api/subscriptions/:id Unsubscribe
   * @apiDescription Unsubscribes a user from a given feed.
   */
  delete: function (req, res) {

    Subscription.findById(req.params.id, (err, subscription) => {

      if (!subscription) {
        return res.error('RESOURCE_NOT_FOUND');
      }

      if (!subscription.userIs(req.user.sub)) {
        return res.error('PERMISSION_DENIED');
      }

      subscription.remove((err) => {
        if (err) {
          return res.error('UNKNOWN_ERROR');
        }
        res.status(204).send();
      });

    });

  },

  /**
   * @apiGroup Subscriptions
   * @api { patch } /api/subscriptions/:id Update
   * @apiParam { String } customTitle A custom name, for display purposes.
   * @apiDescription
   * 	Updates a user's subscription to a given feed. This does not update the
   *  feed, it just updates pivot data for the current user.
   */
  update: function (req, res) {

    Subscription.findById(req.params.id, (err, subscription) => {

      const modifiedSubscription = subscription;

      if (!subscription) {
        return res.error('RESOURCE_NOT_FOUND');
      }

      if (!subscription.userIs(req.user.sub)) {
        return res.error('PERMISSION_DENIED');
      }

      if (req.body.customTitle) {
        modifiedSubscription.customTitle = req.body.customTitle;
      }

      modifiedSubscription.save((err, updatedSubscription) => {
        res.json(updatedSubscription);
      });

    });

  }

};
