module.exports =

  initialState:
    visibility:
      subscriptionNew: false
      subscriptionEdit: false
      subscriptionDelete: false
    newSubError: false

  MODAL_VISIBILITY_UPDATED: (state, action) ->
    visibility = Object.assign state.visibility, action.visibility

    Object.assign {}, state, { visibility }

  MODAL_NEW_SUBSCRIPTION_RETURNED_ERROR: (state, action) ->
    Object.assign {}, state, newSubError: true
