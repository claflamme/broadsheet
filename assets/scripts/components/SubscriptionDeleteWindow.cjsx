React = require 'react'
Modal = require 'react-bootstrap/lib/Modal'
Button = require 'react-bootstrap/lib/Button'

SubscriptionDeleteWindow = (props, context) ->

  unless props.subscription.title
    return null

  <Modal show={ props.show or false } onHide={ -> }>
    <Modal.Header closeButton>
      <Modal.Title>{ props.subscription.title }</Modal.Title>
    </Modal.Header>
    <Modal.Body>
    </Modal.Body>
    <Modal.Footer>
      <Button onClick={ -> }>Close</Button>
    </Modal.Footer>
  </Modal>

SubscriptionDeleteWindow.propTypes =

  subscription: React.PropTypes.object
  show: React.PropTypes.bool

module.exports = SubscriptionDeleteWindow
