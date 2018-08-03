path = require 'path'
express = require 'express'
_ = require 'lodash'
parse = require 'yargs-parser'
mongoose = require 'mongoose'

# --- Helpers ------------------------------------------------------------------
# ==============================================================================

# Starts the express server and any worker modules.
startServer = (app) ->

  if app.argv.work
    app.workers = require('./workers') app

  unless app.argv.serve
    return

  require('./middleware') app

  app.server = app.express.listen process.env.PORT, ->
    console.log 'Listening on port %s', process.env.PORT

# Loads environment variables from a .env file in the root of the user's
# project. If running in production, the warning is silenced if there's no file.
loadEnv =  ->

  dotenvConfig =
    path: path.resolve process.cwd(), '.env'
    silent: process.env.NODE_ENV isnt 'production'

  require('dotenv').load dotenvConfig

# --- Main Export --------------------------------------------------------------
# ==============================================================================

module.exports = (configPath) ->

  loadEnv()

  app = {}

  app.argv = parse process.argv.slice(2), { boolean: ['serve', 'work'] }
  app.config = require configPath
  app.helpers = require('./helpers') app
  app.services = require('./services') app
  app.controllers = require('./controllers') app
  app.express = express()
  app.server = {}
  app.utils = require('./utils') app

  # Server config
  app.express.set 'views', app.utils.getPath app.config.paths.views
  app.express.set 'view engine', 'pug'

  unless process.env.DATABASE_URL
    return startServer app

  console.log 'Connecting to database...'

  mongoose.set 'debug', app.config.db.debug
  mongoose.connect process.env.DATABASE_URL, { useMongoClient: true }, (err) ->
    if err
      # For some reason, not all mongo errors are throwable. throw() will still
      # halt the process, though.
      console.error err
      throw err
    else
      console.log '...connected!'
      startServer app
