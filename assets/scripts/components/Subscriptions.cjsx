React = require 'react'
{ Link, IndexLink } = require 'react-router'
Button = require '../elements/Button'
Badge = require '../elements/Badge'
SubscriptionActions = require '../actions/SubscriptionActions'
SubscriptionsNew = require './SubscriptionsNew'

module.exports = React.createClass

  propTypes:

    subscriptions: React.PropTypes.object.isRequired
    showNewSub: React.PropTypes.bool
    dispatch: React.PropTypes.func.isRequired

  componentWillMount: ->

    @props.dispatch SubscriptionActions.fetchSubscriptions()

  getDefaultProps: ->

    showNewSub: false

  render: ->

    <div>
      <Badge text='me@corylaflamme.com' />
      <div className='subscriptions-section'>
        <ul>
          <li>
            <IndexLink to='/' activeClassName='active'>
              <i className='fa fa-fw fa-rss subscriptionIcon'></i>
              All
            </IndexLink>
          </li>
          { @props.subscriptions.docs.map @_renderSubscription }
        </ul>
      </div>
      <div className='subscriptions-section'>
        <Button
          variant='primary'
          block
          className='newSubscriptionBtn'
          onClick={ @_showNewSubscription }>
          <span>Add Subscription</span>
          &nbsp;
          <i className='fa fa-plus'></i>
        </Button>
      </div>
      <SubscriptionsNew
        show={ @props.showNewSub }
        onHide={ @_hideNewSubscription }
        onSubmit={ @_addSubscription }
        loading={ @props.subscriptions.adding } />
    </div>

  _renderSubscription: (subscription, i) ->

    fallbackTitle = subscription.feed.title or subscription.feed.url

    <li key={ i }>
      <Link
        to={ "/feeds/#{ subscription.feed._id }"}
        activeClassName='active'>
        <img className='subscriptionIcon' src={ subscription.feed.iconUrl } />
        { subscription.customTitle or fallbackTitle }
      </Link>
    </li>

  _addSubscription: (form) ->

    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: ->

    @props.dispatch SubscriptionActions.showNewPrompt()

  _hideNewSubscription: ->

    @props.dispatch SubscriptionActions.hideNewPrompt()
