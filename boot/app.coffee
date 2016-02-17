express = require 'express'
bodyParser = require 'body-parser'
jwt = require 'express-jwt'
config = require '../config'
knex = require('knex') config.db

# Catch uncaught exceptions
process.stderr.on 'data', (data) ->
  console.log data

GLOBAL.App = {}

App.Errors = require '../app/errors'
App.Config = require '../config'
App.Bookshelf = require './bookshelf'
App.Models = require './models'
App.Services = require './services'
App.Controllers = require './controllers'

jwtOpts = secret: process.env.JWT_SECRET

# Start the server
# ------------------------------------------------------------------------------
app = express()
router = express.Router()
auth = jwt(jwtOpts).unless path: require('../app/routes/unprotected')

app.set 'views', App.Config.paths.views
app.set 'view engine', 'jade'
app.use bodyParser.json()
app.use auth

# Custom error handler for express-jwt.
app.use (err, req, res, next) ->
  if err.name is 'UnauthorizedError'
    res.status(401).json error: message: 'Invalid auth token.'

app.use require('../app/routes/router') router

server = app.listen process.env.PORT, ->
  console.log 'Listening on port %s', process.env.PORT
