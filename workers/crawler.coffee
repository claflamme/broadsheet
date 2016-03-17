async = require 'async'
ParserService = App.Services.ParserService
Feed = App.Models.Feed

async.forever (repeat) ->

  new Feed().outdated().fetch().then (feed) ->

    unless feed
      console.log 'No outdated feeds found.'
      setTimeout repeat, 60000 # 60000ms = 1 minute
    else
      console.log 'Processing %s...', feed.get('url')
      ParserService.processFeed feed, repeat
