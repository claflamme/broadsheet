module.exports =

  # This module handles any events dispatched for authentication processes.
  # Logging in or out, registration, password resets, refreshing tokens, w/e.
  #
  # It should not handle events for the current user, like fetching their
  # details or updating "profile" info.

  initialState:

    # A JSON web token issued by the server.
    token: localStorage.getItem 'token'

    # A user model for the token bearer.
    user: null

    # Whether or not there's an authentication/registration request in process.
    loading: false

  AUTH_TOKEN_REQUESTED: (state, action) ->

    Object.assign {}, state, loading: true

  AUTH_TOKEN_RECEIVED: (state, action) ->

    Object.assign {}, state, loading: false, token: action.token

  AUTH_TOKEN_FAILED: (state, action) ->

    Object.assign {}, state, loading: false

  AUTH_USER_RECEIVED: (state, action) ->

    Object.assign {}, state, user: action.user
