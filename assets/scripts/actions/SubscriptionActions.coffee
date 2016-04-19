constants = require '../constants'
api = require '../api'
{ browserHistory } = require 'react-router'

createFeed = (url, cb) ->

  request =
    url: '/api/feeds'
    method: 'post'
    body: { url }

  api.send request, cb

createSubscription = (feedId, cb) ->

  request =
    url: '/api/subscriptions'
    method: 'post'
    body: { feedId }

  api.send request, cb

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

    (dispatch) =>
      dispatch type: constants.SUBSCRIPTIONS_ADDING_NEW
      createFeed url, (res, feed) =>
        createSubscription feed._id, (res, subscription) =>
          dispatch type: constants.SUBSCRIPTIONS_ADDED_NEW
          dispatch @hideNewPrompt()
          dispatch @fetchSubscriptions()

  showNewPrompt: ->

    type: constants.MODAL_NEW_SUBSCRIPTION_TOGGLED, show: true

  hideNewPrompt: ->

    type: constants.MODAL_NEW_SUBSCRIPTION_TOGGLED, show: false

  showEditPrompt: ->

    type: constants.MODAL_EDIT_SUBSCRIPTION_TOGGLED, show: true

  hideEditPrompt: ->

    type: constants.MODAL_EDIT_SUBSCRIPTION_TOGGLED, show: false

  showDeletePrompt: ->

    type: constants.MODAL_DELETE_SUBSCRIPTION_TOGGLED, show: true

  hideDeletePrompt: ->

    type: constants.MODAL_DELETE_SUBSCRIPTION_TOGGLED, show: false

  edit: (subscription) ->

    (dispatch) =>
      dispatch type: constants.SUBSCRIPTIONS_EDITED, subscription: subscription
      dispatch @hideEditPrompt()

      request =
        url: "/api/subscriptions/#{ subscription._id }"
        method: 'PATCH'
        body:
          customTitle: subscription.customTitle

      api.send request

  unsubscribe: (subscription) ->

    (dispatch) =>
      dispatch type: constants.SUBSCRIPTIONS_DELETED, subscription: subscription
      dispatch @hideDeletePrompt()
      browserHistory.push '/'

      request =
        url: "/api/subscriptions/#{ subscription._id }"
        method: 'DELETE'

      api.send request
