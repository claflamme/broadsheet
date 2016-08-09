React = require 'react'
{ Grid, Row, Col, Panel, Input, Button } = require 'react-bootstrap'

module.exports = React.createClass

  propTypes:

    onSubmit: React.PropTypes.func.isRequired
    buttonText: React.PropTypes.string.isRequired

  getInitialState: ->

    email: ''

  render: ->

    <Col md={ 4 } mdOffset={ 3 } lg={ 4 } lgOffset={ 4 } sm={ 6 } smOffset={ 3 }>
      <h1>&nbsp;</h1>
      <form onSubmit={ @_onSubmit }>
        <Input
          type='email'
          placeholder='Email address...'
          onChange={ @_onChange.bind @, 'email' } />
        <Button
          type='submit'
          bsStyle='primary'
          className={ if @props.loading then 'loading' else '' }
          disabled={ @props.loading }
          block>
          { @props.buttonText }
        </Button>
      </form>
    </Col>

  _onChange: (key, e) ->

    @state[key] = e.target.value
    @setState @state

  _onSubmit: (e) ->

    e.preventDefault()

    @props.onSubmit @state.email
