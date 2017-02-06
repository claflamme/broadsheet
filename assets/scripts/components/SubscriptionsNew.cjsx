React = require 'react'
{ Modal, Button, FormControl, Alert } = require 'react-bootstrap'

module.exports = React.createClass

  propTypes:

    show: React.PropTypes.bool.isRequired
    hasError: React.PropTypes.bool.isRequired
    onHide: React.PropTypes.func.isRequired
    onSubmit: React.PropTypes.func.isRequired
    loading: React.PropTypes.bool.isRequired

  getInitialState: ->

    url: ''

  render: ->

    <Modal show={ @props.show } onHide={ @props.onHide } onExited={ @_reset }>
      <form onSubmit={ @_submit }>
        <Modal.Header>
          <Modal.Title>Add a subscription</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          { @_renderError @props }
          <FormControl
            type='text'
            autoFocus
            placeholder='http://examplesite.com/rss.xml'
            value={ @state.url }
            onChange={ @_onChange } />
        </Modal.Body>
        <Modal.Footer>
          <Button bsStyle='link' onClick={ @props.onHide }>
            Cancel
          </Button>
          <Button bsStyle='primary' type='submit'>
            Add
          </Button>
        </Modal.Footer>
      </form>
    </Modal>

  _renderError: (props) ->

    unless props.hasError
      return

    <Alert bsStyle='danger'>
      Uh oh, I don't think that's a valid RSS feed.
    </Alert>

  _onChange: (e) ->

    @setState url: e.target.value

  _reset: ->

    @setState @getInitialState()

  _submit: (e) ->

    e.preventDefault()

    @props.onSubmit @state
