path = require 'path'
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

app = {}

app.config = require '../config'
app.mongoose = require 'mongoose'
app.models = require('./models') app
app.services = require('./services') app
app.controllers = require('./controllers') app
app.express = express()
app.server = {}
app.utils = require('./utils') app

jwtOpts = secret: process.env.JWT_SECRET

# Start the server
# ------------------------------------------------------------------------------
router = express.Router()
auth = jwt(jwtOpts).unless path: require('../app/routes/unprotected')

unless process.env.NODE_ENV is 'production'
  app.express.use morgan 'dev'

app.express.set 'views', app.utils.getPath app.config.paths.views
app.express.set 'view engine', 'jade'
app.express.use bodyParser.json()
app.express.use stylus.middleware stylusOpts
app.express.get '/app.js', browserify app.utils.getPath('assets/scripts/App.cjsx'), browserifyOpts
app.express.use express.static 'public'
app.express.use '/api', auth

# Custom error handler for express-jwt.
app.express.use (err, req, res, next) ->
  if err.name is 'UnauthorizedError'
    res.status(401).json error: message: 'Invalid auth token.'
  else
    res.status(500).json error: message: 'Unexpected error.'
    console.error err.stack

app.express.use require('./errors')

app.express.use require('../app/routes/router') app, router

console.log 'Connecting to database...'
app.mongoose.connect process.env.DATABASE_URL, (err) ->
  if err
    console.error '!!!', err.message, '!!!'
    throw err
  else
    console.log '...connected!'
    require('../workers/crawler') app
    app.server = app.express.listen process.env.PORT, ->
      console.log 'Listening on port %s', process.env.PORT
