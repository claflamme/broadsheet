FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'
each = require 'async/each'
request = require 'request'
moment = require 'moment'
Feed = App.Models.Feed
Article = App.Models.Article

parseArticle = (item) ->

  # Full article data is fetched at "read time", so we don't need to store any
  # more than a brief summary. Text is truncated to 300 characters, paragraph
  # text only, no line breaks.
  summary = item.summary or item.description
  summary = sanitize summary, { allowedTags: [] }
  summary = summary.substring(0, 300).trim()
  summary = summary.replace /\r?\n|\r/g, ''

  output =
    title: item.title.trim()
    url: item.link
    summary: summary
    publishedAt: item.pubdate or moment()

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

  feed.title = meta.title or null
  feed.description = meta.description or null

  feed.save done

addArticles = (parsedArticles, feed, done) ->

  urls = parsedArticles.map (article) -> article.url

  Article.find url: { $in: urls }, (err, foundArticles) ->

    foundUrls = foundArticles.map (article) -> article.url

    # Remove any articles that are already in the DB.
    articlesToInsert = parsedArticles.filter (parsedArticle) ->
      foundUrls.indexOf(parsedArticle.url) is -1

    Article.create articlesToInsert, (err) ->
      console.log 'Done! Added %d articles.', articlesToInsert.length
      done()

module.exports.processFeed = (feed, done) ->

  feed.save (err, feed) ->
    downloadFeed feed.url, (res) ->
      parseStream res, (err, articles, meta) ->
        if err
          throw err
        updateFeed feed, meta, (err, feed) ->
          addArticles articles, feed, done
