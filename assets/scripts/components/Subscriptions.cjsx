React = require 'react'
{ Link, IndexLink } = require 'react-router'
{ Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'
SubscriptionsNew = require './SubscriptionsNew'

module.exports = React.createClass

  propTypes:

    subscriptions: React.PropTypes.array.isRequired
    showNewSub: React.PropTypes.bool
    dispatch: React.PropTypes.func.isRequired

  componentWillMount: ->

    @props.dispatch SubscriptionActions.fetchSubscriptions()

  getDefaultProps: ->

    showNewSub: false

  render: ->

    <div>
      <Button
        block
        bsStyle='primary'
        className='newSubscriptionBtn'
        onClick={ @_showNewSubscription }>
        <span>Add Subscription</span>
        &nbsp;
        <i className='fa fa-plus'></i>
      </Button>
      <ul className='subscriptionsList'>
        <li>
          <IndexLink to='/' activeClassName='active'>
            <i className='fa fa-fw fa-rss'></i>
            &nbsp;
            All
          </IndexLink>
        </li>
        <li>&nbsp;</li>
        { @props.subscriptions.map @_renderSubscription }
      </ul>
      <SubscriptionsNew
        show={ @props.showNewSub }
        onHide={ @_hideNewSubscription }
        onSubmit={ @_addSubscription } />
    </div>

  _renderSubscription: (subscription, i) ->

    fallbackTitle = subscription.feed.title or subscription.feed.url

    <li key={ i }>
      <Link
        to={ "/feeds/#{ subscription.feed._id }"}
        activeClassName='active'>
        { subscription.customTitle or fallbackTitle }
      </Link>
    </li>

  _addSubscription: (form) ->

    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: ->

    @props.dispatch SubscriptionActions.showNewPrompt()

  _hideNewSubscription: ->

    @props.dispatch SubscriptionActions.hideNewPrompt()
