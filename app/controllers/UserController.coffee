bcrypt = require 'bcryptjs'
User = App.Models.User

module.exports = class UserController

  test: (req, res) ->

    res.render 'main'

  register: (req, res) ->

    res.render 'auth/register'

  create: (req, res, next) ->

    res.send 'hello'
