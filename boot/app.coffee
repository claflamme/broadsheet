express = require 'express'
bodyParser = require 'body-parser'
jwt = require 'express-jwt'
config = require '../config'
knex = require('knex') config.db

GLOBAL.App = {}

App.Errors = require '../app/errors'
App.Config = require '../config'
App.Bookshelf = require './bookshelf'
App.Models = require './models'
App.Services = require './services'
App.Controllers = require './controllers'
App.Policies = require './policies'

unprotectedRoutes = [ '/register', '/authenticate' ]
jwtOpts = secret: process.env.JWT_SECRET

# Start the server
# ------------------------------------------------------------------------------
app = express()
auth = jwt(jwtOpts).unless path: unprotectedRoutes

app.set 'views', App.Config.paths.views
app.set 'view engine', 'jade'
app.use bodyParser.json()
app.use auth

# Custom error handler for express-jwt.
app.use (err, req, res, next) ->
  if err.name is 'UnauthorizedError'
    res.status(401).json error: message: 'Invalid auth token.'

require('./routers')(app)

server = app.listen process.env.PORT, ->
  console.log 'Listening on port %s', process.env.PORT
