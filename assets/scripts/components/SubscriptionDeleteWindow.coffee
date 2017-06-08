React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Modal, Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'

unsubscribe = (e, props) ->
  e.preventDefault()

  props.onSubmit props.subscription

SubscriptionDeleteWindow = (props, context) ->
  title = props.subscription.customTitle or props.subscription.feed.title

  el Modal, show: props.show or false, onHide: props.onHide,
    el 'form', onSubmit: ((e) -> unsubscribe e, props),
      el Modal.Header, closeButton: true,
        el Modal.Title, null,
          "Unsubscribe"
      el Modal.Body, null,
        "Are you sure you want to unsubscribe from "
        el 'strong', null,
          title
      el Modal.Footer, null,
        el Button, bsStyle: 'link', onClick: props.onHide,
          "Cancel"
        el Button, bsStyle: 'danger', type: 'submit',
          "Unsubscribe"

SubscriptionDeleteWindow.propTypes =
  subscription: pt.object
  show: pt.bool
  onHide: pt.func

module.exports = SubscriptionDeleteWindow
