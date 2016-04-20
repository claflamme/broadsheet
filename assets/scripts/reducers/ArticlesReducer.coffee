module.exports =

  initialState:
    docs: []
    limit: 10
    offset: 0
    page: 1
    pages: 1
    total: 10
    loading: false

  ARTICLES_RECEIVED: (state, action) ->

    if action.articles.page is 1
      return action.articles

    newData =
      docs: state.docs.concat action.articles.docs
      page: action.articles.page
      loading: false

    Object.assign {}, state, newData

  ARTICLES_REQUESTED: (state, action) ->

    Object.assign {}, state, { loading: true, docs: @initialState.docs }
