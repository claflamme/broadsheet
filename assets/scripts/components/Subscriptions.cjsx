React = require 'react'
{ Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'
SubscriptionsNew = require './SubscriptionsNew'

module.exports = React.createClass

  propTypes:

    subscriptions: React.PropTypes.array.isRequired
    showNewSubscriptionPrompt: React.PropTypes.bool
    dispatch: React.PropTypes.func.isRequired

  componentWillMount: ->

    @props.dispatch SubscriptionActions.fetchSubscriptions()

  getDefaultProps: ->

    showNewSubscriptionPrompt: false

  render: ->

    <div>
      <ul className='subscriptionsList'>
        { @props.subscriptions.map @_renderSubscription }
      </ul>
      <Button onClick={ @_showNewSubscription }>
        Add Subscription
      </Button>
      <SubscriptionsNew
        show={ @props.showNewSubscriptionPrompt }
        onHide={ @_hideNewSubscription }
        onSubmit={ @_addSubscription } />
    </div>

  _renderSubscription: (subscription, i) ->

    fallbackTitle = subscription.feed.title or subscription.feed.url

    <li key={ i }>
      <a href=''>
        { subscription.customTitle or fallbackTitle }
      </a>
    </li>

  _addSubscription: (form) ->

    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: ->

    @props.dispatch SubscriptionActions.showNewPrompt()

  _hideNewSubscription: ->

    @props.dispatch SubscriptionActions.hideNewPrompt()
