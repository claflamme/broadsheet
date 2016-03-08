FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'
async = require 'async'
request = require 'request'
Feed = App.Models.Feed
Article = App.Models.Article

parseArticle = (item) ->

  summary = item.summary or item.description
  summary = sanitize summary, { allowedTags: [] }
  summary = summary.substring(0, 300).trim() + '...'
  summary = summary.replace /\r?\n|\r/g, ''

  output =
    title: item.title.trim()
    url: item.link
    description: item.description.trim()
    summary: summary

  return output

parseStream = (xmlStream, done) ->

  parser = new FeedParser()
  articles = []

  parser.on 'readable', ->
    while item = @read()
      articles.push parseArticle(item)

  parser.on 'end', ->
    done null, articles, @meta

  parser.on 'error', (err) ->
    done err, articles

  xmlStream.pipe parser

downloadFeed = (url, done) ->

  req = request url

  req.on 'error', (err) ->
    console.log err.message

  req.on 'response', (res) ->
    if res.statusCode isnt 200
      return @emit 'error', new Error('Bad status code')
    else
      done @

updateFeed = (feed, meta, done) ->

  feed.set 'title', meta.title or null
  feed.set 'description', meta.description or null

  feed.save().then done

addArticles = (articles, feed, done) ->

  numAdded = 0

  add = (article, cb) ->
    article.feed_id = feed.get 'id'
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
      parseStream res, (err, articles, meta) ->
        if err
          throw err
        updateFeed feed, meta, ->
          addArticles articles, feed, done
