React = require 'react'
{ Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'
SubscriptionsNew = require './SubscriptionsNew'

module.exports = React.createClass

  propTypes:

    subscriptions: React.PropTypes.array.isRequired
    dispatch: React.PropTypes.func.isRequired

  componentWillMount: ->

    @props.dispatch SubscriptionActions.fetchSubscriptions()

  getInitialState: ->

    showNewSubscription: false

  render: ->

    <div>
      <h4>Subscriptions</h4>
      <ul>
        { @props.subscriptions.map @_renderSubscription }
      </ul>
      <Button onClick={ @_showNewSubscription }>
        Add Subscription
      </Button>
      <SubscriptionsNew
        show={ @state.showNewSubscription }
        onHide={ @_hideNewSubscription }
        onSubmit={ @_addSubscription } />
    </div>

  _renderSubscription: (subscription, i) ->

    <li key={ i }>
      { subscription._pivot_custom_title or subscription.title }
    </li>

  _addSubscription: (form) ->

    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: ->

    @setState showNewSubscription: true

  _hideNewSubscription: ->

    @setState showNewSubscription: false
