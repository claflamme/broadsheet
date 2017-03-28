React = require 'react'
c = React.createElement
{ connect } = require 'react-redux'

AuthActions = require '../actions/AuthActions'

mapStateToProps = (state) ->

  token: state.auth.token

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->

    action = AuthActions.redeemNonce @props.location.query.nonce
    @props.dispatch action

  componentWillReceiveProps: (nextProps) ->

    if nextProps.token
      @context.router.push '/'

  render: ->

    c 'p', {}
