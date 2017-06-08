React = require 'react'
el = React.createElement
pt = require 'prop-types'
SubscriptionEditWindow = require './SubscriptionEditWindow'
SubscriptionDeleteWindow = require './SubscriptionDeleteWindow'
SubscriptionActions = require '../actions/SubscriptionActions'

toggleMobileMenu = (e) ->
  document.body.classList.toggle 'show-mobile-menu'

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

renderControls = (props) ->
  editProps =
    title: 'Edit subscription'
    onClick: -> props.dispatch SubscriptionActions.showEditPrompt()

  deleteProps =
    title: 'Unsubscribe'
    onClick: -> props.dispatch SubscriptionActions.showDeletePrompt()

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
    onHide: -> props.dispatch SubscriptionActions.hideEditPrompt()
    initialSubscription: props.subscription
    onSubmit: (subscription) -> editSub props, subscription
    feedUrl: props.subscription.feed.url

  subscriptionDeleteProps =
    show: props.showDeleteSub
    onHide: -> props.dispatch SubscriptionActions.hideDeletePrompt()
    subscription: props.subscription
    onSubmit: (subscription) -> deleteSub props, subscription

  el 'div', null,
    el SubscriptionEditWindow, subscriptionEditProps
    el SubscriptionDeleteWindow, subscriptionDeleteProps

editSub = (props, subscription) ->
  props.dispatch SubscriptionActions.edit subscription

deleteSub = (props, subscription) ->
  props.dispatch SubscriptionActions.unsubscribe subscription

module.exports = FeedTitleBar
