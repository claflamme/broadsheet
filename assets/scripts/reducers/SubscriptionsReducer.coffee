module.exports =

  # This reducer's state is just an array of subscriptions.
  initialState: []

  SUBSCRIPTIONS_RECEIVED: (state, action) ->

    action.subscriptions

  SUBSCRIPTION_EDITED: (state, action) ->

    alert 'sub edited'

    state.subscriptions.map (sub) ->
      if sub._id is action.subscription._id
        action.subscription
      else
        sub
