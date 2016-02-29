async = require 'async'
request = require 'request'
Feed = App.Models.Feed
Article = App.Models.Article
parser = require './ParserService'

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
      title: article.title.trim()
      description: article.description.trim()
      url: article.url.trim()
    new Article(article).save().then ->
      ++numAdded
      cb()
    .catch (err) ->
      cb()

  async.each articles, add, ->
    console.log 'Done! Added %d articles.', numAdded
    done()

module.exports.processFeed = (feed, done) ->

  feed.save(feed.timestamp({method: 'update'})).then ->
    downloadFeed feed.get('url'), (res) ->
      parser.parseStream res, (err, articles) ->
        if err
          throw err
        addArticles articles, feed, done
