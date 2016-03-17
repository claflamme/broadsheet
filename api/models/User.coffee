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

  # The `feedIds` param can be undefined, an integer, or an array of integers.
  subscriptions: (feedIds) ->

    subscriptions = @belongsToMany 'Feed', 'subscriptions'

    if feedIds

      unless feedIds instanceof Array
        feedIds = [feedIds]

      subscriptions = subscriptions.query 'where', 'feed_id', 'in', feedIds

    return subscriptions.withPivot ['custom_title']

  updateSubscription: (feedId, fields) ->

    pivotOpts =
      query: (knex) ->
        knex.where 'feed_id', feedId

    @subscriptions(feedId).updatePivot fields, pivotOpts
