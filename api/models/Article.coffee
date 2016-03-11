module.exports =

  tableName: 'articles'

  feed: ->

    @belongsTo 'Feed'
