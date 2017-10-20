React = require 'react'
{ Component } = React
el = React.createElement
{ connect } = require 'react-redux'
{ Grid, Row, Col } = require 'react-bootstrap'
pick = require 'lodash/pick'

AppNav = require '../components/AppNav'
SubscriptionList = require '../components/SubscriptionList'
AuthActions = require '../actions/AuthActions'
SubscriptionActions = require '../actions/SubscriptionActions'

class Dashboard extends Component

  @contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->
    unless @props.auth.token
      return @context.router.replace '/authenticate'

    @selectActiveSubscription()
    @props.dispatch AuthActions.fetchUser()

  componentDidUpdate: (prevProps) ->
    subs = @props.subscriptions
    if subs.docs.length > 0
      if @props.params.feedId isnt subs.activeSubscription?.feed?._id
        @selectActiveSubscription()

  selectActiveSubscription: ->
    if @props.params.feedId
      sub = @getActiveSubscription @props.params.feedId
      @props.dispatch SubscriptionActions.selectActiveSubscription sub
    else
      @props.dispatch SubscriptionActions.deselectActiveSubscription()

  getActiveSubscription: (feedId) ->
    unless feedId
      return null

    @props.subscriptions.docs.find (subscription, i) ->
      subscription.feed._id is feedId

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

    subscriptionsProps =
      subscriptions: @props.subscriptions.docs
      isAdding: @props.subscriptions.ui.adding
      showNewSub: @props.modals.visibility.subscriptionNew
      newSubError: @props.modals.newSubError
      user: @props.auth.user
      dispatch: @props.dispatch

    el 'div', null,
      el AppNav, childProps
      el Grid, fluid: true, className: 'dashboardGrid',
        el Row, {},
          el Col, xs: 12, sm: 3, lg: 2, className: 'subscriptions dashboard-col',
            el SubscriptionList, subscriptionsProps
          React.cloneElement @props.children, childProps

module.exports = connect((state) -> state) Dashboard
