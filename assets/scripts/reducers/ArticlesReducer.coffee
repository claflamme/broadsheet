module.exports =

  initialState:
    docs: []
    limit: 10
    offset: 0
    page: 1
    pages: 1
    total: 10

  ARTICLES_RECEIVED: (state, action) ->

    action.articles.page = parseInt action.articles.page

    action.articles

  ARTICLES_UPDATED: (state, action) ->

    articles = state.docs.concat action.articles.docs
    page = parseInt action.articles.page

    Object.assign {}, state, { docs: articles, page: page }
