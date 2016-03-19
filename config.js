require('dotenv').load({ silent: true });
const path = require('path');

module.exports = {

  urls: {
    baseUrl: process.env.BASE_URL || 'http://coolsite.com'
  },

  paths: {
    controllers: path.resolve(__dirname, 'api', 'controllers'),
    models: path.resolve(__dirname, 'api', 'models'),
    views: path.resolve(__dirname, 'api', 'views'),
    routers: path.resolve(__dirname, 'api', 'routers'),
    services: path.resolve(__dirname, 'api', 'services')
  },

  // === Authentication ========================================================
  // Settings that pertain to the various authentication packages e.g. passport,
  // express-session, cookie-parser.
  // ---------------------------------------------------------------------------

  auth: {
    bcryptSaltRounds: 10
  }

};
