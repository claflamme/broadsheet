forever = require 'async/forever'

module.exports = (app) ->

  ParserService = app.services.ParserService
  Feed = app.models.Feed

  forever (repeat) ->

    Feed.findMostOutdated (err, feed) ->

      unless feed
        console.log 'No outdated feeds found.'
        console.log 'Waiting %d minute(s)...', app.config.crawler.pollingInterval
        # 60,000 milliseconds in a minute.
        setTimeout repeat, app.config.crawler.pollingInterval * 60000
      else
        console.log 'Processing %s...', feed.get('url')
        ParserService.processFeed feed, repeat
