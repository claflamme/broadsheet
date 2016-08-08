constants = require '../constants'
api = require '../api'

receiveToken = (token) ->

  action = type: constants.AUTH_TOKEN_RECEIVED

  if token
    localStorage.setItem 'token', token
    action.token = token

  action

module.exports =

  requestToken: (type, email) ->

    request =
      url: "/api/auth/#{ type }"
      method: 'POST'
      body: { email }

    (dispatch) =>
      dispatch type: constants.AUTH_TOKEN_REQUESTED
      api.send request, (res, json) =>
        if json.error
          dispatch type: constants.AUTH_TOKEN_FAILED
        else
          dispatch type: constants.AUTH_TOKEN_SUCCESS

  redeemNonce: (nonce) ->

    request =
      url: "/api/auth/redeem"
      query:
        nonce: nonce

    (dispatch) =>
      api.send request, (res, json) =>
        dispatch receiveToken json.token

  signIn: (email) ->

    @requestToken 'authenticate', email

  signUp: (email, password) ->

    @requestToken 'register', email, password

  fetchUser: ->

    request =
      url: '/api/auth/user'

    (dispatch) ->
      dispatch type: constants.AUTH_USER_REQUESTED
      api.send request, (res, json) ->
        dispatch type: constants.AUTH_USER_RECEIVED, user: json.user
