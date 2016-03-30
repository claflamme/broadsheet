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
