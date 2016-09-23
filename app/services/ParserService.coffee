FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'
request = require 'request'
moment = require 'moment'
faviconoclast = require 'faviconoclast'

# Articles sometimes have dates set in the future. Sites will do this to "pin"
# an item until the date has passed. Obviously, we don't want this in a feed,
# so any future dates should be set to when the article is first found.
normalizeArticleDate = (articleDate) ->

  currentDate = moment()
  articleDate or= currentDate

  moment Math.min articleDate, currentDate

module.exports = (app) ->

  Feed = app.models.Feed
  Article = app.models.Article

  parseArticle = (item) ->

    # Full article data is fetched at "read time", so we don't need to store any
    # more than a brief summary. In this case, that's the first sentence.
    summary = item.summary or item.description

    summary = summary.split('</p>').find (p) ->
      sanitize(p, allowedTags: []) isnt ''

    summary = sanitize summary, allowedTags: []

    if summary.length > 200
      summary = "#{ summary.substring(0, 200).trim() }..."

    title: item.title.trim()
    url: item.link
    summary: summary.trim()
    publishedAt: normalizeArticleDate item.pubdate

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

    unless meta?.link
      return new Error "Invalid feed - no metadata: #{ feed.url }"

    feed.title = meta.title or null
    feed.description = meta.description or null

    faviconoclast meta.link, (err, iconUrl) ->
      feed.iconUrl = iconUrl or null
      feed.save done

  addArticles = (parsedArticles, feed, done) ->

    # TODO: this could be redone to pull the X most recent articles in the DB
    # and only compare those URLs (X is the number of items in the feed).
    # - pull the feed, it has 50 items
    # - query the 50 latest articles in the DB for that feed
    # - check the new article URLs against the results from the DB, instead of
    #   querying the entire DB for a list of 10-50 URLs.

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

  processFeed: (feed, done) ->

    feed.updatedAt = new Date()

    feed.save (err, feed) ->
      downloadFeed feed.url, (err, res) ->
        if err
          return done()
        parseStream res, (err, articles, meta) ->
          if err
            return done()
          updateFeed feed, meta, (err, feed) ->
            if err
              return done()
            addArticles articles, feed, done
