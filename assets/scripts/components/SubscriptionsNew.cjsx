React = require 'react'
{ Modal, Button, Input } = require 'react-bootstrap'

module.exports = React.createClass

  propTypes:

    show: React.PropTypes.bool.isRequired
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
          <Input
            type='text'
            standalone
            placeholder='http://examplesite.com/rss.xml'
            ref={ @_focus }
            value={ @state.url }
            onChange={ @_onChange } />
        </Modal.Body>
        <Modal.Footer>
          <Button bsStyle='danger' onClick={ @props.onHide }>
            Cancel
          </Button>
          <Button bsStyle='primary' loading={ @props.loading } type='submit'>
            Add
          </Button>
        </Modal.Footer>
      </form>
    </Modal>

  _focus: (Input) ->

    if Input
      Input.refs.input.focus()

  _onChange: (e) ->

    @setState url: e.target.value

  _reset: ->

    @setState @getInitialState()

  _submit: (e) ->

    e.preventDefault()

    @props.onSubmit @state
