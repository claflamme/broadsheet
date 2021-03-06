Cookies = require 'js-cookie'
constants = require '../constants'
api = require '../api'

receiveToken = (token) ->

  action = type: constants.AUTH_TOKEN_RECEIVED

  if token
    Cookies.set 'token', token
    action.token = token

  action

module.exports =

  redeemNonce: (nonce) ->

    request =
      url: "/api/auth/redeem"
      query:
        nonce: nonce

    (dispatch) =>
      api.send request, (res, json) =>
        dispatch receiveToken json.token

  signIn: (email) ->

    request =
      url: '/api/auth/authenticate'
      method: 'POST'
      body: { email }

    (dispatch) =>
      dispatch type: constants.AUTH_TOKEN_REQUESTED
      api.send request, (res, json) =>
        if json.error
          dispatch type: constants.AUTH_TOKEN_FAILED
        else
          dispatch type: constants.AUTH_TOKEN_SUCCESS

  fetchUser: ->

    request =
      url: '/api/auth/user'

    (dispatch) ->
      dispatch type: constants.AUTH_USER_REQUESTED
      api.send request, (res, json) ->
        dispatch type: constants.AUTH_USER_RECEIVED, user: json.user
