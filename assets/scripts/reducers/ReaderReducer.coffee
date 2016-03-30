module.exports =

  initialState:
    body: ''
    article: null
    visible: false

  ARTICLE_CONTENT_RECEIVED: (state, action) ->

    Object.assign {}, state, { body: action.body, article: action.article }

  ARTICLE_CONTENT_REQUESTED: (state, action) ->

    newData =
      article: action.article
      visible: action.visible
      body: ''

    Object.assign {}, state, newData

  ARTICLE_CONTENT_HIDDEN: (state, action) ->

    Object.assign {}, state, { visible: false }
