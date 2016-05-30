require('dotenv').load silent: true
path = require 'path'

module.exports =

  db:
    debug: process.env.NODE_ENV isnt 'production'

  urls:
    baseUrl: process.env.BASE_URL or 'http://coolsite.com'

  paths:
    root: process.cwd()
    controllers: 'app/controllers'
    models: 'app/models'
    views: 'app/views'
    services: 'app/services'

  auth:
    bcryptSaltRounds: 10

  crawler:
    # The time in minutes before a feed is considered outdated. If a feed hasn't
    # been checked for this long, it will be updated in the next crawl.
    outdatedThreshold: 30
    # The time in minutes to wait before polling for outdated feeds. Once no
    # more outdated feeds are found, the crawler will wait this long before
    # checking again.
    pollingInterval: 10
