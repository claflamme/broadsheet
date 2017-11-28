{ browserHistory } = require 'react-router'

constants = require '../constants'
api = require '../api'
ModalActions = require './ModalActions'

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
  updateSubscriptionUI: (uiProperties) ->
    Object.assign { type: constants.SUBSCRIPTION_UI_UPDATED }, uiProperties

  updateSubscriptionList: (subscriptionList) ->
    type: constants.SUBSCRIPTION_LIST_UPDATED
    subscriptionList: subscriptionList

  fetchSubscriptionList: ->
    (dispatch) =>
      dispatch @updateSubscriptionUI loading: true
      api.send { url: '/api/subscriptions' }, (res, json) =>
        dispatch @updateSubscriptionList json
        dispatch @updateSubscriptionUI loading: false

  add: (url) ->
    (dispatch) =>
      dispatch @updateSubscriptionUI adding: true
      createFeed url, (res, feed) =>
        createSubscription feed._id, (res, json) =>
          if json.error
            return dispatch type: constants.MODAL_NEW_SUBSCRIPTION_RETURNED_ERROR
          dispatch @updateSubscriptionUI adding: false
          dispatch ModalActions.setVisibility subscriptionNew: false
          dispatch @fetchSubscriptionList()

  edit: (subscription) ->
    (dispatch) =>
      request =
        url: "/api/subscriptions/#{ subscription._id }"
        method: 'PATCH'
        body:
          customTitle: subscription.customTitle

      api.send request, (res, json) =>
        dispatch type: constants.SUBSCRIPTION_UPDATED, subscription: json
        dispatch ModalActions.setVisibility subscriptionEdit: false

  unsubscribe: (subscription) ->
    (dispatch) =>
      dispatch type: constants.SUBSCRIPTION_DELETED, subscription: subscription
      dispatch ModalActions.setVisibility subscriptionDelete: false

      request =
        url: "/api/subscriptions/#{ subscription._id }"
        method: 'DELETE'

      api.send request, ->
        browserHistory.push '/'

  move: (docs, dragIndex, hoverIndex) ->
    draggedSubscription = docs[dragIndex]

    docs.splice dragIndex, 1
    docs.splice hoverIndex, 0, draggedSubscription

    docs = docs.map (doc, i) ->
      doc.index = i
      doc

    @updateSubscriptionList docs

  saveOrder: (subscriptions) ->
    subscriptions = subscriptions.map (sub) ->
      { _id: sub._id, index: sub.index }

    request =
      url: '/api/subscriptions'
      method: 'PATCH'
      body: { subscriptions }

    (dispatch) ->
      api.send request

  selectActiveSubscription: (subscription) ->
    type: constants.SUBSCRIPTION_SELECTED
    subscription: subscription

  deselectActiveSubscription: ->
    type: constants.SUBSCRIPTION_DESELECTED
