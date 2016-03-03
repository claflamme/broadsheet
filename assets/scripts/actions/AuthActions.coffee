constants = require '../constants'
api = require '../api'

module.exports =

  receieveToken: (token) ->

    type: constants.AUTH_TOKEN_RECEIVED
    token: token

  requestToken: (type, email, password) ->

    request =
      url: "/api/auth/#{ type }"
      method: 'POST'
      body: { email, password }

    (dispatch) =>
      dispatch type: constants.AUTH_TOKEN_REQUESTED
      api.send request, (res, json) =>
        dispatch @receieveToken json.token

  signIn: (email, password) ->

    @requestToken 'authenticate', email, password

  signUp: (email, password) ->

    @requestToken 'register', email, password
