React = require 'react'
{ Modal, FormGroup, FormControl, ControlLabel, HelpBlock, Button } = require 'react-bootstrap'
SubscriptionActions = require '../actions/SubscriptionActions'

SubscriptionEditWindow = React.createClass

  propTypes:

    initialSubscription: React.PropTypes.object.isRequired
    show: React.PropTypes.bool
    onHide: React.PropTypes.func
    feedUrl: React.PropTypes.string

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
          <FormGroup>
            <ControlLabel>Name:</ControlLabel>
            <FormControl
              type='text'
              autoFocus
              placeholder={ @state.subscription.feed.title }
              value={ @state.subscription.customTitle or '' }
              onChange={ @_onTitleChange } />
          </FormGroup>
          <FormGroup bsSize='small'>
            <ControlLabel>Feed URL:</ControlLabel>
            <FormControl type='text' readOnly value={ @props.feedUrl } />
          </FormGroup>
        </Modal.Body>
        <Modal.Footer>
          <Button bsStyle='link' onClick={ @props.onHide }>Cancel</Button>
          <Button bsStyle='primary' type='submit'>Save</Button>
        </Modal.Footer>
      </form>
    </Modal>

  _editSubscription: (e) ->

    e.preventDefault()

    @props.onSubmit @state.subscription

  _onTitleChange: (e) ->

    updatedSubscription = Object.assign {}, @state.subscription
    updatedSubscription.customTitle = e.target.value

    @setState subscription: updatedSubscription


module.exports = SubscriptionEditWindow
