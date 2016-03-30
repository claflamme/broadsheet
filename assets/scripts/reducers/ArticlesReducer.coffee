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

  ARTICLES_UPDATED: (state, action) ->

    articles = state.docs.concat action.articles.docs

    Object.assign {}, state, { docs: articles, page: action.articles.page }
