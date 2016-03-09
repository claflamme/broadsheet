bcrypt = require 'bcryptjs'

module.exports =

  tableName: 'users'
  hasTimestamps: true
  hidden: ['password']
  rules:
    email: ['maxLength:255']

  initialize: (attributes, options) ->

    @on 'saving', @_saveHashedPassword

  _saveHashedPassword: ->

    unless @hasChanged 'password'
      return

    password = @get 'password'
    salt = bcrypt.genSaltSync App.Config.auth.bcryptSaltRounds

    @set 'password', bcrypt.hashSync password, salt

  passwordIsValid: (providedPassword) ->

    currentPassword = @get 'password'
    bcrypt.compareSync providedPassword, currentPassword

  subscriptions: ->

    @belongsToMany('Feed', 'subscriptions').withPivot ['custom_name']

  subscription: (id) ->

    @subscriptions().query 'where', 'id', '=', id

  updateSubscription: (feedId, fields) ->

    pivotOpts =
      query: (knex) ->
        knex.where 'feed_id', '=', feedId

    @subscription(feedId).updatePivot fields, pivotOpts
