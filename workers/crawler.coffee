forever = require 'async/forever'
ParserService = App.Services.ParserService
Feed = App.Models.Feed

forever (repeat) ->

  Feed.findMostOutdated (err, feed) ->

    unless feed
      console.log 'No outdated feeds found.'
      console.log 'Waiting %d minute(s)...', App.Config.crawler.pollingInterval
      # 60,000 milliseconds in a minute.
      setTimeout repeat, App.Config.crawler.pollingInterval * 60000
    else
      console.log 'Processing %s...', feed.get('url')
      ParserService.processFeed feed, repeat
