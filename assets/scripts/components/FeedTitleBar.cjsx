React = require 'react'
SubscriptionEditWindow = require './SubscriptionEditWindow'
SubscriptionDeleteWindow = require './SubscriptionDeleteWindow'
ModalActions = require '../actions/ModalActions'

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
  showEdit: React.PropTypes.bool

renderControls = (props) ->

  props.dispatch { type: 'hello' }

  <span>
    <span onClick={ -> }>
      [ Edit ]
    </span>
    &nbsp;
    <span>[ Unsubscribe ]</span>
  </span>

renderModals = (props) ->

  <div>
    <SubscriptionEditWindow
      show={ props.showEdit }
      subscription={ props.subscription } />
    <SubscriptionDeleteWindow
      show={ false }
      subscription={ props.subscription } />
  </div>

module.exports = FeedTitleBar
