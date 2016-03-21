require('dotenv').load silent: true
path = require 'path'

module.exports =

  urls:
    baseUrl: process.env.BASE_URL or 'http://coolsite.com'

  paths:
    controllers: path.resolve __dirname, 'api', 'controllers'
    models: path.resolve __dirname, 'api', 'models'
    views: path.resolve __dirname, 'api', 'views'
    routers: path.resolve __dirname, 'api', 'routers'
    services: path.resolve __dirname, 'api', 'services'

  auth:
    bcryptSaltRounds: 10
