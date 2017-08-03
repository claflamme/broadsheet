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

    type: constants.SUBSCRIPTION_LIST_UPDATED
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
        createSubscription feed._id, (res, json) =>
          if json.error
            return dispatch type: constants.MODAL_NEW_SUBSCRIPTION_RETURNED_ERROR
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
      request =
        url: "/api/subscriptions/#{ subscription._id }"
        method: 'PATCH'
        body:
          customTitle: subscription.customTitle

      api.send request, (res, json) =>
        dispatch type: constants.SUBSCRIPTION_UPDATED, subscription: json
        dispatch @hideEditPrompt()


  unsubscribe: (subscription) ->

    (dispatch) =>
      dispatch type: constants.SUBSCRIPTION_DELETED, subscription: subscription
      dispatch @hideDeletePrompt()

      request =
        url: "/api/subscriptions/#{ subscription._id }"
        method: 'DELETE'

      api.send request, ->
        browserHistory.push '/'

  move: (docs, dragIndex, hoverIndex) ->

    dragSub = docs[dragIndex]

    docs.splice dragIndex, 1
    docs.splice hoverIndex, 0, dragSub

    docs = docs.map (doc, i) ->
      doc.index = i
      doc

    type: constants.SUBSCRIPTION_LIST_UPDATED
    subscriptions: docs

  saveOrder: (subscriptions) ->

    subscriptions = subscriptions.map (sub) ->
      { _id: sub._id, index: sub.index }

    request =
      url: '/api/subscriptions'
      method: 'PATCH'
      body: { subscriptions }

    (dispatch) ->
      api.send request
