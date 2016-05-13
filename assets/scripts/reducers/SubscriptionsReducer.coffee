module.exports =

  initialState:
    # List of subscriptions.
    docs: []
    # The list of subscriptions is being fetched.
    loading: false
    # A new subscription is being added.
    adding: false

  SUBSCRIPTIONS_RECEIVED: (state, action) ->

    newState =
      docs: action.subscriptions
      loading: false

    Object.assign {}, state, newState

  SUBSCRIPTIONS_EDITED: (state, action) ->

    docs = state.docs.map (sub) ->
      if sub._id is action.subscription._id
        action.subscription
      else
        sub

    Object.assign {}, state, { docs }

  SUBSCRIPTIONS_DELETED: (state, action) ->

    docs = state.docs.filter (sub) ->
      sub._id isnt action.subscription._id

    Object.assign {}, state, { docs }

  SUBSCRIPTIONS_ADDING_NEW: (state, actions) ->

    Object.assign {}, state, { adding: true }

  SUBSCRIPTIONS_ADDED_NEW: (state, actions) ->

    Object.assign {}, state, { adding: false }
