bcrypt = require 'bcryptjs'

module.exports =

  tableName: 'users'
  hasTimestamps: true
  hidden: ['password']
  rules:
    email: ['maxLength:255']

  initialize: (attributes, options) ->

    @on 'saving', @hashPassword

  hashPassword: ->

    unless @hasChanged 'password'
      return

    password = @get 'password'
    hash = bcrypt.hashSync password, 10

    @set 'password', hash

  passwordIsValid: (providedPassword) ->

    currentPassword = @get 'password'
    bcrypt.compareSync providedPassword, currentPassword
