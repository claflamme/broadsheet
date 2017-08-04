React = require 'react'
el = React.createElement
pt = require 'prop-types'
SubscriptionEditWindow = require './SubscriptionEditWindow'
SubscriptionDeleteWindow = require './SubscriptionDeleteWindow'
SubscriptionActions = require '../actions/SubscriptionActions'
ModalActions = require '../actions/ModalActions'

toggleMobileMenu = (e) ->
  document.body.classList.toggle 'show-mobile-menu'

renderControls = (props) ->
  editProps =
    title: 'Edit subscription'
    onClick: -> props.dispatch ModalActions.setVisibility subscriptionEdit: true

  deleteProps =
    title: 'Unsubscribe'
    onClick: -> props.dispatch ModalActions.setVisibility subscriptionDelete: true

  el 'ul', className: 'feed-title-bar-icons',
    el 'li', null,
      el 'a', editProps,
        el 'i', className: 'fa fa-pencil'
        el 'small', null,
          "Edit"
    el 'li', null,
      el 'a', deleteProps,
        el 'i', className: 'fa fa-times'
        el 'small', null,
          'Unsubscribe'

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
  el 'div', className: 'feedTitleBar',
    el 'i', className: 'fa fa-bars mobile-menu-button', onClick: toggleMobileMenu
    el 'i', className: 'fa fa-times mobile-menu-button', onClick: toggleMobileMenu
    el 'h3', className: 'feed-title',
      props.title or el('span', null, '')
    if props.showControls then renderControls props
    if props.subscription then renderModals props

FeedTitleBar.propTypes =
  title: pt.string
  showControls: pt.bool
  subscription: pt.object
  showEditSub: pt.bool
  showDeleteSub: pt.bool

module.exports = FeedTitleBar
