import React, { createElement as el } from 'react'
import pt from 'prop-types'
import { Row, Col } from 'react-bootstrap'

SubscriptionEditWindow = require './SubscriptionEditWindow'
SubscriptionDeleteWindow = require './SubscriptionDeleteWindow'
SubscriptionActions = require '../actions/SubscriptionActions'
ModalActions = require '../actions/ModalActions'

renderControls = (props) ->
  editProps =
    title: 'Edit subscription'
    onClick: -> props.dispatch ModalActions.setVisibility subscriptionEdit: true

  deleteProps =
    title: 'Unsubscribe'
    onClick: -> props.dispatch ModalActions.setVisibility subscriptionDelete: true

  el 'ul', className: 'feed-title-bar__icon-list text-right',
    el 'li', className: 'feed-title-bar__icon',
      el 'a', editProps,
        el 'i', className: 'fa fa-pencil'
    el 'li', className: 'feed-title-bar__icon',
      el 'a', deleteProps,
        el 'i', className: 'fa fa-times'

renderModals = (props) ->
  subscriptionEditProps =
    show: props.showEditSub
    initialSubscription: props.subscription
    feedUrl: props.subscription.feed.url
    onHide: ->
      props.dispatch ModalActions.setVisibility subscriptionEdit: false
    onSubmit: (subscription) ->
      props.dispatch SubscriptionActions.edit subscription

  subscriptionDeleteProps =
    show: props.showDeleteSub
    subscription: props.subscription
    onHide: ->
      props.dispatch ModalActions.setVisibility subscriptionDelete: false
    onSubmit: (subscription) ->
      props.dispatch SubscriptionActions.unsubscribe subscription

  el 'div', null,
    el SubscriptionEditWindow, subscriptionEditProps
    el SubscriptionDeleteWindow, subscriptionDeleteProps

FeedTitleBar = (props, context) ->
  el 'div', className: 'feed-title-bar',
    el Row, null,
      el Col, xs: (if props.showControls then 9 else 12),
        el 'h3', className: 'feed-title-bar__title',
          props.title or el('span', null, '')
      if props.showControls
        el Col, xs: 3,
          renderControls props
    if props.subscription then renderModals props

FeedTitleBar.propTypes =
  title: pt.string
  showControls: pt.bool
  subscription: pt.object
  showEditSub: pt.bool
  showDeleteSub: pt.bool

module.exports = FeedTitleBar
