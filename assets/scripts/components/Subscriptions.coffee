React = require 'react'
{ Component } = React
el = React.createElement
pt = require 'prop-types'
HTML5Backend = require 'react-dnd-html5-backend'
{ DragDropContext } = require 'react-dnd'
{ IndexLink } = require 'react-router'
{ Button  } = require 'react-bootstrap'
UserBadge = require '../components/UserBadge'
SubscriptionActions = require '../actions/SubscriptionActions'
SubscriptionsNew = require './SubscriptionsNew'
SubscriptionListItem = require './SubscriptionListItem'

class Subscriptions extends Component

  @propTypes:
    subscriptions: pt.array.isRequired
    isAdding: pt.bool
    isLoading: pt.bool
    showNewSub: pt.bool
    newSubError: pt.bool
    dispatch: pt.func.isRequired

  @defaultProps:
    showNewSub: false

  componentWillMount: ->
    @props.dispatch SubscriptionActions.fetchSubscriptions()

  _addSubscription: (form) =>
    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: =>
    @props.dispatch SubscriptionActions.showNewPrompt()

  _hideNewSubscription: =>
    @props.dispatch SubscriptionActions.hideNewPrompt()

  _onLinkClicked: ->
    document.body.classList.remove 'show-mobile-menu'

  _onSubscriptionMoved: (dragIndex, hoverIndex) =>
    @props.dispatch SubscriptionActions.move @props.subscriptions, dragIndex, hoverIndex

  _onSubscriptionDropped: =>
    @props.dispatch SubscriptionActions.saveOrder @props.subscriptions

  _renderSubscription: (subscription, i) =>
    subscriptionItemProps =
      key: i
      index: subscription.index
      title: subscription.customTitle or subscription.feed.title
      feedUrl: subscription.feed.url
      iconUrl: subscription.feed.iconUrl
      feedId: subscription.feed._id
      subId: subscription._id
      onClick: @_onLinkClicked
      onMove: @_onSubscriptionMoved
      onDrop: @_onSubscriptionDropped

    el SubscriptionListItem, subscriptionItemProps

  render: ->
    subscriptionsNewProps =
      show: @props.showNewSub
      hasError: @props.newSubError
      onHide: @_hideNewSubscription
      onSubmit: @_addSubscription
      loading: @props.isAdding

    el 'div', null,
      el UserBadge, title: @props.user?.email
      el 'div', className: 'subscriptions-section',
        el 'ul', className: 'subscriptions-list',
          el 'li', null,
            el IndexLink, to: '/', activeClassName: 'active', onClick: @_onLinkClicked,
              el 'i', className: 'fa fa-fw fa-rss subscriptionIcon'
              "All"
          @props.subscriptions.map @_renderSubscription
      el 'div', className: 'subscriptions-section',
        el Button, bsStyle: 'primary', block: true, onClick: @_showNewSubscription,
          el 'span', null,
            "Add Subscription "
          el 'i', className: 'fa fa-plus'
      el SubscriptionsNew, subscriptionsNewProps

module.exports = DragDropContext(HTML5Backend) Subscriptions
