LocalStrategy = require('passport-local').Strategy
User = App.Models.User
LocalLogin = require './LocalLogin'
LocalRegister = require './LocalRegister'

localOpts =
  usernameField: 'email'
  passReqToCallback: true

module.exports = (passport) ->

  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    User.findById id, (err, user) ->
      done err, user

  passport.use 'local-login', new LocalStrategy localOpts, LocalLogin
  passport.use 'local-register', new LocalStrategy localOpts, LocalRegister

  module.exports = passport
