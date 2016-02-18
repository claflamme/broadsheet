async = require 'async'
request = require 'request'
Feed = App.Models.Feed
Article = App.Models.Article
parser = App.Services.ParserService

downloadFeed = (url, done) ->

  req = request url

  req.on 'error', (err) ->
    console.log err.message

  req.on 'response', (res) ->
    if res.statusCode isnt 200
      return @emit 'error', new Error('Bad status code')
    else
      done @

addArticles = (articles, feed, done) ->

  numAdded = 0

  add = (article, cb) ->
    article =
      feed_id: feed.get 'id'
      title: article.title
      description: article.description.trim()
      url: article.url
    new Article(article).save().then ->
      ++numAdded
      cb()
    .catch (err) ->
      cb()

  async.each articles, add, ->
    console.log 'Done! Added %d articles.', numAdded
    done()

processFeed = (feed, done) ->

  feed.save(feed.timestamp({method: 'update'})).then ->
    downloadFeed feed.get('url'), (res) ->
      parser.parseStream res, (err, articles) ->
        if err
          throw err
        addArticles articles, feed, done

crawl = ->

  async.forever (repeat) ->
    new Feed().oldest().fetch().then (feed) ->
      unless feed
        console.log 'No outdated feeds found.'
        # 300000ms = 5 minutes
        setTimeout repeat, 300000
      else
        console.log 'Processing %s...', feed.get('url')
        processFeed feed, repeat

module.exports = crawl
