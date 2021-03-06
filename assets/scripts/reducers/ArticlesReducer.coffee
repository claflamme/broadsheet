import { uniqBy } from 'lodash'

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
      return Object.assign {}, state, { loading: false }, action.articles

    newData =
      docs: state.docs.concat action.articles.docs
      page: action.articles.page
      loading: false

    # Remove duplicate articles, if new ones have been added since the list was
    # last refreshed
    newData.docs = uniqBy newData.docs, '_id'

    Object.assign {}, state, newData

  ARTICLES_REQUESTED: (state, action) ->

    newState =
      loading: true
      docs: state.docs

    if action.clearDocs
      newState.docs = @initialState.docs

    Object.assign {}, state, newState
