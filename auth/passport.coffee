LocalStrategy = require('passport-local').Strategy
User = App.Models.User
LocalLogin = require './LocalLogin'
LocalRegister = require './LocalRegister'

localOpts =
  usernameField: 'email'

serializeUser = (user, done) ->

  done null, user.get 'id'

deserializeUser = (id, done) ->

  user = new User { id: id }

  user.fetch().then (user) ->
    done null, user
  .catch (err) ->
    done err

module.exports = (passport) ->

  passport.serializeUser serializeUser
  passport.deserializeUser deserializeUser

  passport.use 'local-login', new LocalStrategy localOpts, LocalLogin
  passport.use 'local-register', new LocalStrategy localOpts, LocalRegister

  module.exports = passport
