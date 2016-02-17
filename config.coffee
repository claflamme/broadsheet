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
    controllers: path.resolve __dirname, 'api', 'controllers'
    models: path.resolve __dirname, 'api', 'models'
    views: path.resolve __dirname, 'api', 'views'
    routers: path.resolve __dirname, 'api', 'routers'
    services: path.resolve __dirname, 'api', 'services'

  # === Authentication =========================================================
  # Settings that pertain to the various authentication packages e.g. passport,
  # express-session, cookie-parser.
  # ----------------------------------------------------------------------------

  auth:

    # Route path to redirect to when logging out.
    logoutRedirect: '/'

    bcryptSaltRounds: 10
