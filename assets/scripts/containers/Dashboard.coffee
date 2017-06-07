React = require 'react'
{ Component } = React
el = React.createElement
{ connect } = require 'react-redux'
{ Grid, Row, Col } = require 'react-bootstrap'
pick = require 'lodash/pick'

Subscriptions = require '../components/Subscriptions'
AuthActions = require '../actions/AuthActions'

class Dashboard extends Component

  @contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->
    unless @props.auth.token
      return @context.router.replace '/authenticate'

    @props.dispatch AuthActions.fetchUser()

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
      isAdding: @props.subscriptions.adding
      showNewSub: @props.modals.showNewSub
      newSubError: @props.modals.newSubError
      user: @props.auth.user
      dispatch: @props.dispatch

    el Grid, fluid: true, className: 'dashboardGrid',
      el Row, {},
        el Col, xs: 12, sm: 3, lg: 2, className: 'subscriptions dashboard-col',
          el Subscriptions, subscriptionsProps
        React.cloneElement @props.children, childProps

module.exports = connect((state) -> state) Dashboard
