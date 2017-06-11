module.exports =

  env:
    silent: process.env.NODE_ENV is 'production'
    path: '.env' # Path to the env file, from the project root.

  db:
    debug: process.env.NODE_ENV isnt 'production'

  urls:
    baseUrl: process.env.BASE_URL or 'http://coolsite.com'

  paths:
    root: process.cwd()
    routes: 'app/routes'
    helpers: 'app/helpers'
    controllers: 'app/controllers'
    models: 'app/models'
    views: 'app/views'
    services: 'app/services'
    workers: 'app/workers'
    public: 'public'

  auth:
    email:
      from: 'Broadsheet <noreply@broadsheet.ca>'
      subject: 'Login Request'
      callbackUrl: "#{ process.env.BASE_URL }/callback"

  browserify: [
    {
      inputPath: 'assets/scripts/App.coffee'
      outputPath: 'app.js' # Relative to the public folder.
      options:
        transform: ['coffeeify']
        extensions: ['.coffee']
    }
  ]

  stylus:
    inputPath: 'assets/styles'

  mail:
    mailgun:
      secretKey: process.env.MAILGUN_SECRET_KEY
      domain: process.env.MAILGUN_DOMAIN

  crawler:
    # The time in minutes before a feed is considered outdated. If a feed hasn't
    # been checked for this long, it will be updated in the next crawl.
    outdatedThreshold: 30
    # The time in minutes to wait before polling for outdated feeds. Once no
    # more outdated feeds are found, the crawler will wait this long before
    # checking again.
    pollingInterval: 10
