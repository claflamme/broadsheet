express = require 'express'
bodyParser = require 'body-parser'
config = require '../config'
knex = require('knex') config.db

GLOBAL.App = {}

App.Config = require '../config'
App.Bookshelf = require './bookshelf'
App.Models = require './models'
App.Services = require './services'
App.Controllers = require './controllers'
App.Policies = require './policies'

# Start the server
# ------------------------------------------------------------------------------
app = express()

app.set 'views', App.Config.paths.views
app.set 'view engine', 'jade'
app.use bodyParser.urlencoded extended: true

require('./routers')(app)

server = app.listen process.env.PORT, ->
  console.log 'Listening on port %s', process.env.PORT
