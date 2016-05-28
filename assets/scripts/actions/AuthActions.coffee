constants = require '../constants'
api = require '../api'

module.exports =

  receiveToken: (token) ->

    action = type: constants.AUTH_TOKEN_RECEIVED

    if token
      localStorage.setItem 'token', token
      action.token = token

    action

  requestToken: (type, email, password) ->

    request =
      url: "/api/auth/#{ type }"
      method: 'POST'
      body: { email, password }

    (dispatch) =>
      dispatch type: constants.AUTH_TOKEN_REQUESTED
      api.send request, (res, json) =>
        if json.error
          dispatch  type: constants.AUTH_TOKEN_FAILED
        else
          dispatch @receiveToken json.token

  signIn: (email, password) ->

    @requestToken 'authenticate', email, password

  signUp: (email, password) ->

    @requestToken 'register', email, password

  fetchUser: ->

    request =
      url: '/api/auth/user'

    (dispatch) ->
      dispatch type: constants.AUTH_USER_REQUESTED
      api.send request, (res, json) ->
        dispatch type: constants.AUTH_USER_RECEIVED, user: json.user
