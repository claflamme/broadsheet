# This module serves as the project bootstrapper. It initializes all of the
# required components (models, controllers, etc) and then starts the server.
# ==============================================================================
require('dotenv').load()

express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
session = require 'express-session'
flash = require 'connect-flash'
mongoose = require 'mongoose'
MongoStore = require('connect-mongo')(session)

mongoose.connect process.env.MONGO_URL

GLOBAL.App =
  Config: require '../config'

App.Models = require './models'
App.Controllers = require './controllers'
App.Policies = require './policies'
App.Passport = require('../auth/passport') require 'passport'

# Start the server
# ------------------------------------------------------------------------------
app = express()
app.set 'views', App.Config.paths.views
app.set 'view engine', 'jade'
app.use cookieParser()
app.use bodyParser.urlencoded({ extended: true })

# Passport setup
app.use session
  secret: App.Config.auth.sessionSecret
  resave: false
  saveUninitialized: false
  cookie:
    secure: App.Config.auth.secureCookie
  store: new MongoStore { mongooseConnection: mongoose.connection }

app.use App.Passport.initialize()
app.use App.Passport.session()
app.use flash()

require('./routers')(app)

server = app.listen process.env.PORT, ->
  host = server.address().address
  port = server.address().port
  console.log 'Listening on port %s', port
