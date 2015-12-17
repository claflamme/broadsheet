module.exports =

  tableName: 'feeds'
  hasTimestamps: true

  subscribers: ->
    @belongsToMany 'User'
