FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'
each = require 'async/each'
request = require 'request'
moment = require 'moment'
faviconoclast = require 'faviconoclast'
Feed = App.Models.Feed
Article = App.Models.Article

parseArticle = (item) ->

  # Full article data is fetched at "read time", so we don't need to store any
  # more than a brief summary. In this case, that's the first sentence.
  summary = item.summary or item.description

  summary = summary.split('</p>').find (p) ->
    sanitize(p, allowedTags: []) isnt ''

  summary = sanitize summary, allowedTags: []

  if summary.length > 200
    summary = "#{ summary.substring(0, 200).trim() }..."

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
      err = new Error('Bad status code')
      @emit 'error', err
      return done err, @
    else
      done null, @

updateFeed = (feed, meta, done) ->

  feed.title = meta.title or null
  feed.description = meta.description or null

  faviconoclast meta.link or url, (err, iconUrl) ->
    feed.iconUrl = iconUrl
    feed.save done

addArticles = (parsedArticles, feed, done) ->

  urls = parsedArticles.map (article) -> article.url

  Article.find url: { $in: urls }, (err, foundArticles) ->

    foundUrls = foundArticles.map (article) -> article.url

    # Remove any articles that are already in the DB.
    articlesToInsert = parsedArticles.filter (parsedArticle) ->
      foundUrls.indexOf(parsedArticle.url) is -1

    # Add the feed ID to remaining articles.
    articlesToInsert = articlesToInsert.map (parsedArticle) ->
      parsedArticle.feed = feed._id
      parsedArticle

    Article.create articlesToInsert, (err) ->
      console.log 'Done! Added %d articles.', articlesToInsert.length
      done()

module.exports.processFeed = (feed, done) ->

  feed.updatedAt = new Date()

  feed.save (err, feed) ->
    downloadFeed feed.url, (err, res) ->
      if err
        return done()
      parseStream res, (err, articles, meta) ->
        if err
          throw err
        updateFeed feed, meta, (err, feed) ->
          addArticles articles, feed, done
