React = require 'react'
{ Component } = React
el = React.createElement
pt = require 'prop-types'
{ connect } = require 'react-redux'

AuthActions = require '../actions/AuthActions'

class AuthCallback extends Component

  @contextTypes:
    router: pt.object

  componentDidMount: ->
    action = AuthActions.redeemNonce @props.location.query.nonce
    @props.dispatch action

  componentDidUpdate: ->
    if @props.token
      @context.router.push '/'

  render: ->
    el 'p', {}

mapStateToProps = (state) ->
  token: state.auth.token

module.exports = connect(mapStateToProps) AuthCallback
