React = require 'react'
SubscriptionActions = require '../actions/SubscriptionActions'

module.exports = React.createClass

  propTypes:

    subscriptions: React.PropTypes.array.isRequired
    dispatch: React.PropTypes.func.isRequired

  componentWillMount: ->

    @props.dispatch SubscriptionActions.fetchSubscriptions()

  render: ->

    <ul>
      { @props.subscriptions.map @_renderSubscription }
    </ul>

  _renderSubscription: (subscription, i) ->

    <li key={ i }>
      { subscription._pivot_custom_name }
    </li>
