React = require 'react'
{ Component } = React
el = React.createElement
{ connect } = require 'react-redux'
{ Grid, Row, Col } = require 'react-bootstrap'
pick = require 'lodash/pick'

AppNav = require '../components/AppNav'
SubscriptionList = require '../components/SubscriptionList'
SubscriptionNewWindow = require '../components/SubscriptionNewWindow'
ZeroState = require '../components/ZeroState'
AuthActions = require '../actions/AuthActions'
SubscriptionActions = require '../actions/SubscriptionActions'
ModalActions = require '../actions/ModalActions'

class Dashboard extends Component

  @contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->
    unless @props.auth.token
      return @context.router.replace '/authenticate'

    @props.dispatch AuthActions.fetchUser()
    @props.dispatch SubscriptionActions.fetchSubscriptionList()

  _addSubscription: (form) =>
    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: =>
    @props.dispatch ModalActions.setVisibility subscriptionNew: true

  _hideNewSubscription: =>
    @props.dispatch ModalActions.setVisibility subscriptionNew: false

  render: ->
    # Prevent any "flicker" when redirecting to login screen.
    unless @props.auth.token
      return null

    # Any child components of this route handler will receive these as props.
    childProps = pick @props, [
      'dispatch'
      'auth'
      'articles'
      'modals'
      'reader'
      'subscriptions'
    ]

    childProps.user = @props.auth.user
    childProps.subscriptions.active = @props.subscriptions.docs.find (sub) =>
      sub.feed._id is @props.params.feedId

    subscriptionsProps =
      subscriptions: @props.subscriptions.docs
      user: @props.auth.user
      dispatch: @props.dispatch

    subscriptionNewProps =
      show: @props.modals.visibility.subscriptionNew
      hasError: @props.modals.newSubError
      onHide: @_hideNewSubscription
      onSubmit: @_addSubscription
      loading: @props.subscriptions.ui.adding

    el 'div', null,
      el AppNav, childProps
      el Grid, fluid: true, className: 'dashboardGrid',
        unless @props.subscriptions.fetched
          null
        else if subscriptionsProps.subscriptions.length > 0
          el Row, null,
            el Col, xs: 12, sm: 3, lg: 2, className: 'subscriptions dashboard-col',
              el SubscriptionList, subscriptionsProps
            React.cloneElement @props.children, childProps
        else
          el Row, null,
            el Col, xs: 12,
              el ZeroState, onClick: @_showNewSubscription
      el SubscriptionNewWindow, subscriptionNewProps

module.exports = connect((state) -> state) Dashboard
