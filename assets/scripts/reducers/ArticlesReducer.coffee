module.exports =

  initialState:
    docs: []
    limit: 10
    offset: 0
    page: 1
    pages: 1
    total: 10

  ARTICLES_RECEIVED: (state, action) ->

    action.articles
