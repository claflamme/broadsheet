React = require 'react'
{ Component } = React
el = React.createElement
pt = require 'prop-types'
{ Modal, FormGroup, FormControl, ControlLabel, HelpBlock, Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'

class SubscriptionEditWindow extends Component

  @propTypes:
    initialSubscription: pt.object.isRequired
    show: pt.bool
    onHide: pt.func
    feedUrl: pt.string

  constructor: (props) ->
    super props

    @state =
      subscription: props.initialSubscription

  componentWillReceiveProps: (nextProps) ->
    if nextProps.initialSubscription
      @setState subscription: nextProps.initialSubscription

  _editSubscription: (e) ->
    e.preventDefault()

    @props.onSubmit @state.subscription

  _onTitleChange: (e) ->
    updatedSubscription = Object.assign {}, @state.subscription
    updatedSubscription.customTitle = e.target.value

    @setState subscription: updatedSubscription

  render: ->
    titleInputProps =
      type: 'text'
      autoFocus: true
      placeholder: @state.subscription.feed.title
      value: @state.subscription.customTitle or ''
      onChange: @_onTitleChange

    el Modal, show: (@props.show or false), onHide: @props.onHide,
      el 'form', onSubmit: @_editSubscription,
        el Modal.Header, closeButton: true,
          el Modal.Title, null,
            "Edit subscription"
        el Modal.Body, null,
          el FormGroup, null,
            el ControlLabel, null,
              "Name:"
            el FormControl, titleInputProps
          el FormGroup, bsSize: 'small',
            el ControlLabel, null,
              "Feed URL:"
            el FormControl, type: 'text', readOnly: true, value: @props.feedUrl
        el Modal.Footer, null,
          el Button, bsStyle: 'link', onClick: @props.onHide,
            "Cancel"
          el Button, bsStyle: 'primary', type: 'submit',
            "Save"

module.exports = SubscriptionEditWindow
