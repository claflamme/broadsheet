module.exports =

  initialState:
    body: null
    doc: null
    loading: false
    req: null

  ARTICLE_CONTENT_RECEIVED: (state, action) ->

    newState =
      body: action.body
      doc: action.doc
      loading: false
      req: @initialState.req

    Object.assign {}, state, newState

  ARTICLE_CONTENT_REQUESTED: (state, action) ->

    if state.req
      state.req.abort()

    newState =
      body: @initialState.body
      doc: action.doc
      loading: true
      req: action.req

    Object.assign {}, state, newState
