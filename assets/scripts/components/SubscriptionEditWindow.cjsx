React = require 'react'
Modal = require 'react-bootstrap/lib/Modal'
Button = require 'react-bootstrap/lib/Button'
Input = require 'react-bootstrap/lib/Input'

SubscriptionEditWindow = (props, context) ->

  unless props.subscription
    return null

  <Modal bsSize='small' show={ props.show or false } onHide={ props.onHide }>
    <Modal.Header closeButton>
      <Modal.Title>Edit subscription</Modal.Title>
    </Modal.Header>
    <Modal.Body>
      <Input label='Name:' type='text' placeholder={ props.subscription.feed.title } />
    </Modal.Body>
    <Modal.Footer>
      <Button bsStyle='danger' onClick={ props.onHide }>Cancel</Button>
      <Button bsStyle='primary' onClick={ -> }>Save</Button>
    </Modal.Footer>
  </Modal>

SubscriptionEditWindow.propTypes =

  subscription: React.PropTypes.object
  show: React.PropTypes.bool
  onHide: React.PropTypes.func

module.exports = SubscriptionEditWindow
