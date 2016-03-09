constants = require '../constants'
api = require '../api'

module.exports =

  receiveSubscriptions: (subscriptions) ->

    type: constants.SUBSCRIPTIONS_RECEIVED
    subscriptions: subscriptions

  fetchSubscriptions: ->

    request =
      url: '/api/subscriptions'

    (dispatch) =>
      dispatch type: constants.SUBSCRIPTIONS_REQUESTED
      api.send request, (res, json) =>
        dispatch @receiveSubscriptions json

  add: (url) ->

    request =
      url: '/api/subscriptions'
      method: 'post'
      body: { url }

    (dispatch) =>
      dispatch type: constants.SUBSCRIPTIONS_ADDING_NEW
      api.send request, (res, json) =>
        dispatch type: constants.SUBSCRIPTIONS_ADDED_NEW
        dispatch @fetchSubscriptions()
