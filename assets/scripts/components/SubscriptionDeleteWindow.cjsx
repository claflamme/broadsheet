React = require 'react'
Modal = require 'react-bootstrap/lib/Modal'
Button = require 'react-bootstrap/lib/Button'

SubscriptionDeleteWindow = (props, context) ->

  title = props.subscription.customTitle or props.subscription.feed.title

  <Modal show={ props.show or false } onHide={ props.onHide }>
    <Modal.Header closeButton>
      <Modal.Title>Unsubscribe</Modal.Title>
    </Modal.Header>
    <Modal.Body>
      Are you sure you want to unsubscribe from <strong>{ title }</strong>?
    </Modal.Body>
    <Modal.Footer>
      <Button bsStyle='danger' onClick={ props.onHide }>Cancel</Button>
      <Button bsStyle='primary'>Unsubscribe</Button>
    </Modal.Footer>
  </Modal>

SubscriptionDeleteWindow.propTypes =

  subscription: React.PropTypes.object
  show: React.PropTypes.bool
  onHide: React.PropTypes.func

module.exports = SubscriptionDeleteWindow
