/* globals App */

const validator = require('validator');
const AuthService = App.Services.AuthService;

function validateAuthRequest (req, res, cb) {

  const email = req.body.email;
  const password = req.body.password;

  if (!(email && password)) {
    return res.error('AUTH_MISSING_FIELD');
  }

  if (!validator.isEmail(email)) {
    return res.error('AUTH_INVALID_EMAIL');
  }

  cb(email, password, sendResponse.bind(this, res));

}

function sendResponse (res, errKey, user) {

  if (errKey) {
    return res.error(errKey);
  }

  AuthService.generateToken(user, (token) => {
    res.json({ token: token, user: user });
  });

}

module.exports = {

  /**
   * @apiGroup Auth
   *
   * @api { post } /api/auth/authenticate Authenticate
   * @apiParam { String } email A valid email address.
   * @apiParam { String } password Max 72 characters (bcrypt hard limit).
   *
   * @apiDescription
   *  Attempts to authenticate a set of credentials. Provides the user model and
   *  an auth token if successful.
   */
  authenticate: function (req, res) {
    validateAuthRequest(req, res, AuthService.authenticate);
  },

  /**
   * @apiGroup Auth
   *
   * @api { post } /api/auth/register Register
   * @apiParam { String } email A valid email address.
   * @apiParam { String } password Max 72 characters (bcrypt hard limit).
   *
   * @apiDescription
   *  Creates a new user account. If successful, returns the user model and
   *  an auth token.
   */
  register: function (req, res) {
    validateAuthRequest(req, res, AuthService.register);
  }

};
