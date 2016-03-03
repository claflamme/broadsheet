constants = require '../constants'
api = require '../api'

module.exports =

  receieveToken: (token) ->

    type: constants.AUTH_TOKEN_RECEIVED
    token: token

  requestToken: (email, password) ->

    request =
      url: '/api/auth/authenticate'
      method: 'POST'
      body: { email, password }

    (dispatch) =>
      dispatch type: constants.AUTH_TOKEN_REQUESTED
      api.send request, (res, json) =>
        dispatch @receieveToken json.token

  createAccount: (email, password) ->

    request =
      url: '/api/auth/register'
      method: 'POST'
      body: { email, password }

    (dispatch) =>
      dispatch type: constants.AUTH_TOKEN_REQUESTED
      api.send request
