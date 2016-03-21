module.exports =

  initialState:
    showNewSubscriptionPrompt: false

  SUBSCRIPTIONS_PROMPT_OPENING: (state, action) ->

    Object.assign {}, state, showNewSubscriptionPrompt: true

  SUBSCRIPTIONS_PROMPT_CLOSING: (state, action) ->

    Object.assign {}, state, showNewSubscriptionPrompt: false
