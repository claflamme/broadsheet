constants = require '../constants'
api = require '../api'

module.exports =

  fetchAll: ->

    request =
      url: '/api/subscriptions/articles'

    (dispatch) ->
      api.send request, (res, articles) ->
        action =
          type: constants.ARTICLES_RECEIVED
          articles: articles
        dispatch action
