url = require 'url'
FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'
request = require 'request'
moment = require 'moment'
faviconoclast = require 'faviconoclast'
cheerio = require 'cheerio'

Feed = require '../models/Feed'
Article = require '../models/Article'

parseUrl = url.parse
resolveUrl = url.resolve

feedTypes = [
  'application/rss+xml'
  'application/atom+xml'
  'application/rdf+xml'
]

linkIsRssFeed = (attrs) ->

  unless attrs
    return false

  if attrs.title and attrs.title.toLowerCase() is 'rss'
    return true

  if attrs.type
    isValidFeedType = feedTypes.some (feedType) ->
      feedType is attrs.type
    if isValidFeedType
      return true

  return false

# Articles sometimes have dates set in the future. Sites will do this to "pin"
# an item until the date has passed. Obviously, we don't want this in a feed,
# so any future dates should be set to when the article is first found.
normalizeArticleDate = (articleDate) ->

  currentDate = moment()
  articleDate or= currentDate

  moment Math.min articleDate, currentDate

module.exports = (app) ->
  findRss = (res, done) ->

    html = ''

    res.on 'data', (data) ->
      html += data.toString()

    res.on 'error', (err) ->
      console.error 'findRss error:\n'
      console.error err
      done err

    res.on 'end', ->
      $ = cheerio.load html
      links = []
      $('link').each (i) ->
        attrs = $(@).attr()
        if linkIsRssFeed attrs
          links.push attrs
          return false
      if links.length > 0
        parsedUrl = parseUrl links[0].href
        # This if/else block is for resolving relative URLs.
        if parsedUrl.hostname
          downloadFeed links[0].href, done
        else
          rootUrl = "#{ res.request.uri.protocol }//#{ res.request.uri.host }/"
          downloadFeed resolveUrl(rootUrl, links[0].href), done
      else
        done 404

  parseArticle = (item) ->

    # Full article data is fetched at "read time", so we don't need to store any
    # more than a brief summary. In this case, that's the first sentence.
    summary = item.summary or item.description or ''

    summary = summary.split('</p>').find (p) ->
      sanitize(p, allowedTags: []) isnt ''

    summary = if summary
      sanitize summary, allowedTags: []
    else
      ''

    if summary.length > 200
      summary = "#{ summary.substring(0, 200).trim() }..."

    title: item.title.trim()
    url: item.link
    summary: summary.trim()
    author: item.author
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

    requestOpts =
      url: url
      headers:
        'user-agent': 'Broadsheet RSS Reader'

    req = request requestOpts

    req.on 'error', (err) ->
      console.error url, err
      return done err

    req.on 'response', (res) ->
      if res.statusCode isnt 200
        err = new Error('Bad status code')
        @emit 'error', err
      else
        contentType = res.headers['content-type']

        isRssFeed = ['rss', 'rdf', 'atom', 'xml'].some (type) ->
          contentType.indexOf(type) > -1

        if isRssFeed
          done null, @, url
        else
          findRss res, done

  updateFeed = (feed, meta, realUrl, done) ->

    unless meta?.link
      return new Error "Invalid feed - no metadata: #{ feed.url }"

    feed.title = meta.title or null
    feed.description = meta.description or null
    feed.url = realUrl

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

    Article.find { url: { $in: urls }, feed: feed._id }, (err, foundArticles) ->

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

  deleteOldArticles = (feed) ->

    twoWeeksAgo = moment().subtract 2, 'weeks'

    console.log 'Deleting old articles from %s', feed.url

    query =
      feed: feed._id
      publishedAt:
        $lt: twoWeeksAgo

    Article.remove query, (err) ->
      if err
        console.error 'Error removing old articles from %s', feed.url
        console.error err
      else
        console.log 'Success! Removed old articles from %s', feed.url

  processFeed: (feed, done) ->

    feed.updatedAt = new Date()

    deleteOldArticles feed

    # @TODO: Refactor to async waterfall.
    feed.save (err, feed) ->
      downloadFeed feed.url, (err, res, realUrl) ->
        if err
          return done err
        parseStream res, (err, articles, meta) ->
          if err
            return done err
          updateFeed feed, meta, realUrl, (err, feed) ->
            if err
              return done err
            addArticles articles, feed, done
