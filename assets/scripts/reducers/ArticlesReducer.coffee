module.exports =

  initialState:
    docs: []
    limit: 10
    offset: 0
    page: 1
    pages: 1
    total: 10

  ARTICLES_RECEIVED: (state, action) ->

    if action.articles.page is 1
      return action.articles

    articles = state.docs.concat action.articles.docs
    newData = docs: articles, page: action.articles.page

    return Object.assign {}, state, newData
