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
    routers: path.resolve __dirname, 'app', 'routers'
    services: path.resolve __dirname, 'app', 'services'

  # === Authentication =========================================================
  # Settings that pertain to the various authentication packages e.g. passport,
  # express-session, cookie-parser.
  # ----------------------------------------------------------------------------

  auth:

    # Route path to redirect to when logging out.
    logoutRedirect: '/'

    bcryptSaltRounds: 10
