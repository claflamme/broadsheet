module.exports =

  initialState:
    
    # A JSON web token issued by the server.
    token: null

    # Whether or not there's an authentication/registration request in process.
    loading: false

  AUTH_TOKEN_REQUESTED: (state, action) ->

    Object.assign {}, state, { loading: true }

  AUTH_TOKEN_RECEIVED: (state, action) ->

    Object.assign {}, state, { token: action.token }
