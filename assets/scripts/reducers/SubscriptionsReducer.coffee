module.exports =

  # This reducer's state is just an array of subscriptions.
  initialState: []

  SUBSCRIPTIONS_RECEIVED: (state, action) ->

    action.subscriptions

  SUBSCRIPTIONS_EDITED: (state, action) ->

    state.map (sub) ->
      if sub._id is action.subscription._id
        action.subscription
      else
        sub

  SUBSCRIPTIONS_DELETED: (state, action) ->

    state.filter (sub) ->
      sub._id isnt action.subscription._id
