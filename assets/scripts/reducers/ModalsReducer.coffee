module.exports =

  initialState:
    newSubscription:
      show: false
    editSubscription:
      show: false
      subscription: {}

  MODAL_NEW_SUBSCRIPTION_TOGGLED: (state, action) ->

    newState = @initialState

    if action.show
      newState =
        newSubscription:
          show: action.show

    Object.assign {}, state, newState

  MODAL_EDIT_SUBSCRIPTION_TOGGLED: (state, action) ->

    newState = @initialState

    if action.show
      newState =
        editSubscription:
          show: action.show
          subscription: action.subscription

    Object.assign {}, state, newState
