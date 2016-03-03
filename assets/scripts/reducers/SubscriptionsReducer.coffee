module.exports =

  # This reducer's state is just an array of subscriptions.
  initialState: []

  SUBSCRIPTIONS_RECEIVED: (state, action) ->

    action.subscriptions
