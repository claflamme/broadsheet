module.exports =

  initialState:
    # List of subscriptions.
    docs: []
    # The list of subscriptions is being fetched.
    loading: false
    # A new subscription is being added.
    adding: false

  SUBSCRIPTION_LIST_UPDATED: (state, action) ->
    # Subscriptions that haven't been dragged-and-dropped yet will have their
    # sort index set to null.
    action.subscriptions.sort (a, b) ->
      if a.index is null and b.index is null
        return 0
      if a.index is null
        return 1
      if b.index is null
        return -1
      a.index - b.index

    subscriptions = action.subscriptions.map (sub, i) ->
      sub.index or= i
      sub

    newState =
      docs: subscriptions
      loading: false

    Object.assign {}, state, newState

  SUBSCRIPTION_UPDATED: (state, action) ->
    docs = state.docs.map (sub) ->
      if sub._id is action.subscription._id
        action.subscription
      else
        sub

    Object.assign {}, state, { docs }

  SUBSCRIPTION_DELETED: (state, action) ->
    docs = state.docs.filter (sub) ->
      sub._id isnt action.subscription._id

    Object.assign {}, state, { docs }

  SUBSCRIPTIONS_ADDING_NEW: (state, actions) ->
    Object.assign {}, state, { adding: true }

  SUBSCRIPTIONS_ADDED_NEW: (state, actions) ->
    Object.assign {}, state, { adding: false }
