module.exports =

  initialState:
    body: null
    doc: null
    loading: false

  ARTICLE_CONTENT_RECEIVED: (state, action) ->

    newState =
      body: action.body
      doc: action.doc
      loading: false

    Object.assign {}, state, newState

  ARTICLE_CONTENT_REQUESTED: (state, action) ->

    newState =
      body: @initialState.body
      doc: action.doc
      loading: true

    Object.assign {}, state, newState
