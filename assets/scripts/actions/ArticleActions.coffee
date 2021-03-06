constants = require '../constants'
api = require '../api'

fetchArticles = (path, dispatch, opts = {}) ->

  opts = Object.assign { page: 1, clearDocs: false }, opts

  request =
    url: path
    query: { page: opts.page }

  dispatch type: constants.ARTICLES_REQUESTED, clearDocs: opts.clearDocs

  api.send request, (res, articles) ->
    dispatch type: constants.ARTICLES_RECEIVED, articles: articles
    if articles.page is 1
      # Pretty sloppy to reset scroll position this way, but it works for now.
      document.querySelector('.article-list-col').scrollTop = 0

module.exports =

  fetchAll: (opts) ->

    (dispatch) ->
      fetchArticles '/api/subscriptions/articles', dispatch, opts

  fetchByFeed: (feedId, opts) ->

    (dispatch) ->
      fetchArticles "/api/feeds/#{ feedId }/articles", dispatch, opts

  fetchContent: (article) ->

    request =
      url: "/api/articles/#{ article._id }"

    (dispatch) ->
      req = api.send request, (res, content) ->
        action =
          type: constants.ARTICLE_CONTENT_RECEIVED
          body: content.body or 'There was an error fetching this article.'
          doc: article
        dispatch action

      contentRequestedAction =
        type: constants.ARTICLE_CONTENT_REQUESTED
        doc: article
        req: req

      dispatch contentRequestedAction

  hideReader: ->

    { type: constants.ARTICLE_CONTENT_HIDDEN }
