constants = require '../constants'
api = require '../api'

fetchArticles = (request, dispatch) ->

  # Pretty sloppy to reset scroll position this way, but it works for now.
  api.send request, (res, articles) ->
    dispatch type: constants.ARTICLES_RECEIVED, articles: articles
    document.querySelector('.articleListCol').scrollTop = 0

module.exports =

  fetchAll: ->

    request =
      url: '/api/subscriptions/articles'

    (dispatch) ->
      fetchArticles request, dispatch

  fetchBySubscription: (subscriptionId) ->

    request =
      url: "/api/subscriptions/#{ subscriptionId }/articles"

    (dispatch) ->
      fetchArticles request, dispatch
