React = require 'react'
{ connect } = require 'react-redux'
pick = require 'lodash/pick'
AuthActions = require '../actions/AuthActions'

mapStateToProps = (state) -> state

module.exports = connect(mapStateToProps) React.createClass

  displayName: 'Dashboard'

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    unless @props.auth.token
      return @context.router.replace '/authenticate'

    @props.dispatch AuthActions.fetchUser()

  render: ->

    # Prevent any "flicker" when redirecting to login screen.
    unless @props.auth.token
      return null

    # Any authenticated components (i.e. children of this one) will receive
    # these as props.
    authenticatedProps = pick @props, [
      'dispatch', 'auth', 'articles', 'modals', 'reader', 'subscriptions'
    ]

    React.cloneElement @props.children, authenticatedProps
