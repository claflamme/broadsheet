React = require 'react'
{ Modal, Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'

SubscriptionDeleteWindow = (props, context) ->

  title = props.subscription.customTitle or props.subscription.feed.title

  <Modal show={ props.show or false } onHide={ props.onHide }>
    <form onSubmit={ (e) -> unsubscribe e, props }>
      <Modal.Header closeButton>
        <Modal.Title>Unsubscribe</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        Are you sure you want to unsubscribe from <strong>{ title }</strong>?
      </Modal.Body>
      <Modal.Footer>
        <Button bsStyle='link' onClick={ props.onHide }>Cancel</Button>
        <Button bsStyle='danger' type='submit'>Unsubscribe</Button>
      </Modal.Footer>
    </form>
  </Modal>

SubscriptionDeleteWindow.propTypes =

  subscription: React.PropTypes.object
  show: React.PropTypes.bool
  onHide: React.PropTypes.func

unsubscribe = (e, props) ->

  e.preventDefault()

  props.onSubmit props.subscription

module.exports = SubscriptionDeleteWindow
