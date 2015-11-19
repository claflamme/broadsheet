require('dotenv').load()
path = require 'path'

module.exports =

  db:
    client: 'postgresql'
    connection: process.env.DATABASE_URL
    ssl: true
    pool:
      min: 2
      max: 10
    migrations:
      tableName: 'migrations'

  urls:
    baseUrl: process.env.BASE_URL or 'http://coolsite.com'

  paths:
    controllers: path.resolve __dirname, 'app', 'controllers'
    models: path.resolve __dirname, 'app', 'models'
    views: path.resolve __dirname, 'app', 'views'
    policies: path.resolve __dirname, 'app', 'policies'
    routers: path.resolve __dirname, 'app', 'routers'

  # === Authentication =========================================================
  # Settings that pertain to the various authentication packages e.g. passport,
  # express-session, cookie-parser.
  # ----------------------------------------------------------------------------

  auth:

    # Secret key to use when generating session IDs.
    sessionSecret: process.env.SESSION_SECRET or 'mysecretkey'

    # Secure cookies require an HTTPS connection. If they are enabled over plain
    # HTTP, cookies will not be set.
    secureCookies: process.env.SECURE_COOKIES or false

    # Route path to redirect to when logging out.
    logoutRedirect: '/'
