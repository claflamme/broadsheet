React = require 'react'
HTML5Backend = require 'react-dnd-html5-backend'
{ DragDropContext } = require 'react-dnd'
{ IndexLink } = require 'react-router'
{ Button  } = require 'react-bootstrap'
UserBadge = require '../components/UserBadge'
SubscriptionActions = require '../actions/SubscriptionActions'
SubscriptionsNew = require './SubscriptionsNew'
SubscriptionListItem = require './SubscriptionListItem'

module.exports = DragDropContext(HTML5Backend) React.createClass

  propTypes:

    subscriptions: React.PropTypes.object.isRequired
    showNewSub: React.PropTypes.bool
    newSubError: React.PropTypes.bool
    dispatch: React.PropTypes.func.isRequired

  componentWillMount: ->

    @props.dispatch SubscriptionActions.fetchSubscriptions()

  getDefaultProps: ->

    showNewSub: false

  render: ->

    @props.subscriptions.docs.sort (a, b) -> a.index - b.index

    <div>
      <UserBadge title={ @props.user?.email } />
      <div className='subscriptions-section'>
        <ul className='subscriptions-list'>
          <li>
            <IndexLink
              to='/'
              activeClassName='active'
              onClick={ @_onLinkClicked }>
              <i className='fa fa-fw fa-rss subscriptionIcon'></i>
              All
            </IndexLink>
          </li>
          { @props.subscriptions.docs.map @_renderSubscription }
        </ul>
      </div>
      <div className='subscriptions-section'>
        <Button
          bsStyle='primary'
          block
          onClick={ @_showNewSubscription }>
          <span>Add Subscription</span>
          &nbsp;
          <i className='fa fa-plus'></i>
        </Button>
      </div>
      <SubscriptionsNew
        show={ @props.showNewSub }
        hasError={ @props.newSubError }
        onHide={ @_hideNewSubscription }
        onSubmit={ @_addSubscription }
        loading={ @props.subscriptions.adding } />
    </div>

  _renderSubscription: (subscription, i) ->

    <SubscriptionListItem
      key={ i }
      index={ subscription.index }
      title={ subscription.customTitle or subscription.feed.title  }
      feedUrl={ subscription.feed.url }
      iconUrl={ subscription.feed.iconUrl }
      feedId={ subscription.feed._id }
      subId={ subscription._id }
      onClick={ @_onLinkClicked }
      onMove={ @_onSubscriptionMoved } />

  _addSubscription: (form) ->

    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: ->

    @props.dispatch SubscriptionActions.showNewPrompt()

  _hideNewSubscription: ->

    @props.dispatch SubscriptionActions.hideNewPrompt()

  _onLinkClicked: ->

    document.body.classList.remove 'show-mobile-menu'

  _onSubscriptionMoved: (dragIndex, hoverIndex)->

    @props.dispatch SubscriptionActions.move dragIndex, hoverIndex
