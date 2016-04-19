React = require 'react'
SubscriptionEditWindow = require './SubscriptionEditWindow'
SubscriptionDeleteWindow = require './SubscriptionDeleteWindow'
SubscriptionActions = require '../actions/SubscriptionActions'

# The small little bar at the top of the list of articles. Contains the title of
# the current feed (e.g. "All subscriptions", or "CBC World News"), as well as
# the Edit and Unsubscribe buttons.

FeedTitleBar = (props, context) ->

  <div className='feedTitleBar'>
    <h3 className='feedTitle'>{ props.title }</h3>
    { if props.showControls then renderControls props }
    { if props.subscription then renderModals props }
  </div>

FeedTitleBar.propTypes =

  title: React.PropTypes.string.isRequired
  showControls: React.PropTypes.bool
  subscription: React.PropTypes.object
  showEditSub: React.PropTypes.bool
  showDeleteSub: React.PropTypes.bool

renderControls = (props) ->

  <span>
    <span onClick={ -> props.dispatch SubscriptionActions.showEditPrompt() }>
      [ Edit ]
    </span>
    &nbsp;
    <span onClick={ -> props.dispatch SubscriptionActions.showDeletePrompt() }>
      [ Unsubscribe ]
    </span>
  </span>

renderModals = (props) ->

  <div>
    <SubscriptionEditWindow
      show={ props.showEditSub }
      onHide={ -> props.dispatch SubscriptionActions.hideEditPrompt() }
      initialSubscription={ props.subscription }
      onSubmit={ (subscription) -> editSub props, subscription } />
    <SubscriptionDeleteWindow
      show={ props.showDeleteSub }
      onHide={ -> props.dispatch SubscriptionActions.hideDeletePrompt() }
      subscription={ props.subscription }
      onSubmit={ (subscription) -> deleteSub props, subscription} />
  </div>

editSub = (props, subscription) ->

  props.dispatch SubscriptionActions.edit subscription

deleteSub = (props, subscription) ->

  props.dispatch SubscriptionActions.unsubscribe subscription

module.exports = FeedTitleBar
