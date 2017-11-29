pick = require 'lodash/pick'

module.exports =

  initialState:
    docs: []
    ui:
      loading: false
      adding: false

  SUBSCRIPTION_LIST_UPDATED: (state, action) ->
    # Subscriptions that haven't been dragged-and-dropped yet will have their
    # sort index set to null.
    action.subscriptionList.sort (a, b) ->
      if a.index is null and b.index is null
        return 0
      if a.index is null
        return 1
      if b.index is null
        return -1
      a.index - b.index

    Object.assign {}, state, {
      loading: false
      docs: action.subscriptionList.map (subscription, i) ->
        subscription.index or= i
        subscription
    }

  SUBSCRIPTION_UPDATED: (state, action) ->
    docs = state.docs.map (sub) ->
      if sub._id is action.subscription._id
        action.subscription
      else
        sub

    { state..., docs }

  SUBSCRIPTION_DELETED: (state, action) ->
    docs = state.docs.filter (sub) ->
      sub._id isnt action.subscription._id

    { state..., docs }

  SUBSCRIPTION_UI_UPDATED: (state, action) ->
    uiProps = pick action, Object.keys(@initialState.ui)
    ui = { state.ui..., uiProps... }

    { state..., ui }
