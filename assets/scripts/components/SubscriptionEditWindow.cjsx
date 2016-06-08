React = require 'react'
{ Modal, Input, Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'

SubscriptionEditWindow = React.createClass

  propTypes:

    initialSubscription: React.PropTypes.object.isRequired
    show: React.PropTypes.bool
    onHide: React.PropTypes.func

  componentWillReceiveProps: (nextProps) ->

    if nextProps.initialSubscription
      @setState subscription: nextProps.initialSubscription

  getInitialState: ->

    subscription: @props.initialSubscription

  render: ->

    <Modal show={ @props.show or false } onHide={ @props.onHide }>
      <form onSubmit={ @_editSubscription }>
        <Modal.Header closeButton>
          <Modal.Title>Edit subscription</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Input
            type='text'
            standalone
            ref={ @_focus }
            placeholder={ @state.subscription.feed.title }
            value={ @state.subscription.customTitle or '' }
            onChange={ @_onTitleChange } />
        </Modal.Body>
        <Modal.Footer>
          <Button bsStyle='danger' onClick={ @props.onHide }>Cancel</Button>
          <Button bsStyle='primary' type='submit'>Save</Button>
        </Modal.Footer>
      </form>
    </Modal>

  _focus: (Input) ->

    if Input
      Input.refs.input.focus()

  _editSubscription: (e) ->

    e.preventDefault()

    @props.onSubmit @state.subscription

  _onTitleChange: (e) ->

    updatedSubscription = Object.assign {}, @state.subscription
    updatedSubscription.customTitle = e.target.value

    @setState subscription: updatedSubscription


module.exports = SubscriptionEditWindow
