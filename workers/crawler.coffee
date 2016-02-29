async = require 'async'
ParserService = App.Services.ParserService
Feed = App.Models.Feed

module.exports = ->

  async.forever (repeat) ->
    new Feed().mostOutdated().fetch().then (feed) ->
      unless feed
        console.log 'No outdated feeds found.'
        # 60000ms = 1 minute
        setTimeout repeat, 60000
      else
        console.log 'Processing %s...', feed.get('url')
        ParserService.processFeed feed, repeat
