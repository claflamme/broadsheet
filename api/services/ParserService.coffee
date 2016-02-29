FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'
async = require 'async'
request = require 'request'
Feed = App.Models.Feed
Article = App.Models.Article

parseArticle = (item) ->

  # Prefer <summary> tags to full article content.
  description = item.summary or item.description

  # Strip out <img> tags.
  description = sanitize description, { allowedTags: ['p'] }

  # Truncate long text blobs.
  if description.length > 500
    description = description.substring(0, 500) + '...'

  return output =
    title: item.title
    url: item.link
    date: new Date item.pubdate
    description: description

parseStream = (xmlStream, done) ->

  parser = new FeedParser()
  articles = []

  parser.on 'readable', ->
    while item = @read()
      articles.push parseArticle(item)

  parser.on 'end', ->
    done null, articles

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
      parseStream res, (err, articles) ->
        if err
          throw err
        addArticles articles, feed, done
