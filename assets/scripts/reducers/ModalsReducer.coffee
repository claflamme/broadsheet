module.exports =

  initialState:
    newSubscription:
      show: false
    editSubscription:
      show: false

  MODAL_NEW_SUBSCRIPTION_TOGGLED: (state, action) ->

    newState = @initialState

    if action.show
      newState =
        newSubscription:
          show: action.show

    Object.assign {}, state, newState
