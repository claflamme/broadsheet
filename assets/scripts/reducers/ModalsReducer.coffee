module.exports =

  initialState:
    showNewSub: false
    newSubError: false
    showEditSub: false
    showDeleteSub: false

  MODAL_NEW_SUBSCRIPTION_TOGGLED: (state, action) ->

    Object.assign {}, @initialState, showNewSub: action.show

  MODAL_NEW_SUBSCRIPTION_RETURNED_ERROR: (state, action) ->

    Object.assign {}, state, newSubError: true

  MODAL_EDIT_SUBSCRIPTION_TOGGLED: (state, action) ->

    Object.assign {}, @initialState, showEditSub: action.show

  MODAL_DELETE_SUBSCRIPTION_TOGGLED: (state, action) ->

    Object.assign {}, @initialState, showDeleteSub: action.show
