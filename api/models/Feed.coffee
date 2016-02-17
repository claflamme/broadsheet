moment = require 'moment'

module.exports =

  tableName: 'feeds'
  hasTimestamps: true

  subscribers: ->

    @belongsToMany 'User'

  outdated: ->

    threshold = moment().utc().subtract 10, 'minutes'

    return @where 'updated_at', '<', threshold
