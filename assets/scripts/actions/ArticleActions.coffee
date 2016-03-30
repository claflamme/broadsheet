constants = require '../constants'
api = require '../api'

fetchArticles = (request, dispatch) ->

  # Pretty sloppy to reset scroll position this way, but it works for now.
  api.send request, (res, articles) ->
    dispatch type: constants.ARTICLES_RECEIVED, articles: articles
    if articles.page is 1
      document.querySelector('.articleListCol').scrollTop = 0

module.exports =

  fetchAll: (page = 1) ->

    request =
      url: '/api/subscriptions/articles'
      query: { page }

    (dispatch) ->
      fetchArticles request, dispatch

  fetchBySubscription: (subscriptionId, page = 1) ->

    request =
      url: "/api/subscriptions/#{ subscriptionId }/articles"
      query: { page }

    (dispatch) ->
      fetchArticles request, dispatch

  fetchContent: (article) ->

    request =
      url: '/api/proxy/article'
      query: { url: article.url }

    contentRequestedAction =
      type: constants.ARTICLE_CONTENT_REQUESTED
      article: article
      visible: true

    (dispatch) ->
      dispatch contentRequestedAction
      api.send request, (res, content) ->
        action =
          type: constants.ARTICLE_CONTENT_RECEIVED
          body: content.body
          article: article
        dispatch action

  hideContent: ->

    type: constants.ARTICLE_CONTENT_HIDDEN
