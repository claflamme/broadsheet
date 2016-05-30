express = require 'express'
bodyParser = require 'body-parser'
jwt = require 'express-jwt'
stylus = require 'stylus'
morgan = require 'morgan'
browserify = require 'browserify-middleware'
bootstrap = require 'bootstrap-styl'
config = require '../config'

browserifyOpts =
  transform: ['coffee-reactify']
  extensions: ['.coffee', '.cjsx']

stylusOpts =
  src: 'assets/styles'
  dest: 'public'
  compile: (str, path) ->
    stylus(str)
    .set 'filename', path
    .set 'compress', process.env.NODE_ENV is 'production'
    .use bootstrap()

global.App = {}

App.Errors = require '../api/errors'
App.Config = require '../config'
App.Mongoose = require 'mongoose'
App.Models = require './models'
App.Services = require './services'
App.Controllers = require './controllers'

jwtOpts = secret: process.env.JWT_SECRET

# Start the server
# ------------------------------------------------------------------------------
app = express()
router = express.Router()
auth = jwt(jwtOpts).unless path: require('../api/routes/unprotected')

unless process.env.NODE_ENV is 'production'
  app.use morgan 'dev'

app.set 'views', App.Config.paths.views
app.set 'view engine', 'jade'
app.use bodyParser.json()
app.use stylus.middleware stylusOpts
app.get '/app.js', browserify 'assets/scripts/App.cjsx', browserifyOpts
app.use express.static 'public'
app.use '/api', auth

# Custom error handler for express-jwt.
app.use (err, req, res, next) ->
  if err.name is 'UnauthorizedError'
    res.status(401).json error: message: 'Invalid auth token.'
  else
    res.status(500).json error: message: 'Unexpected error.'
    console.error err.stack

app.use require('./errors')

app.use require('../api/routes/router') router

console.log 'Connecting to database...'
App.Mongoose.connect process.env.DATABASE_URL, (err) ->
  if err
    console.error '!!!', err.message, '!!!'
    throw err
  else
    console.log '...connected!'
    require '../workers/crawler'
    server = app.listen process.env.PORT, ->
      console.log 'Listening on port %s', process.env.PORT
