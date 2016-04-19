module.exports =

  initialState:
    showNewSub: false
    showEditSub: false
    showDeleteSub: false

  MODAL_NEW_SUBSCRIPTION_TOGGLED: (state, action) ->

    Object.assign {}, @initialState, showNewSub: action.show

  MODAL_EDIT_SUBSCRIPTION_TOGGLED: (state, action) ->

    Object.assign {}, @initialState, showEditSub: action.show

  MODAL_DELETE_SUBSCRIPTION_TOGGLED: (state, action) ->

    Object.assign {}, @initialState, showDeleteSub: action.show
