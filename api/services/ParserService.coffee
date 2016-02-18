FeedParser = require 'feedparser'
sanitize = require 'sanitize-html'

parseArticle = (item) ->

  # Prefer <summary> tags to full article content.
  description = if item.summary then item.summary else item.description

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

module.exports =

  parseStream: (xmlStream, done) ->

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
