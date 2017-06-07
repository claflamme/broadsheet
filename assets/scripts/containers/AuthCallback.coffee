React = require 'react'
{ Component } = React
el = React.createElement
{ connect } = require 'react-redux'

AuthActions = require '../actions/AuthActions'

class AuthCallback extends Component

  @contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->
    action = AuthActions.redeemNonce @props.location.query.nonce
    @props.dispatch action

  componentWillReceiveProps: (nextProps) ->
    if nextProps.token
      @context.router.push '/'

  render: ->
    el 'p', {}

mapStateToProps = (state) ->
  token: state.auth.token

module.exports = connect(mapStateToProps) AuthCallback
