React = require 'react'
{ Grid, Row, Col, Panel, Input } = require 'react-bootstrap'
Button = require '../elements/Button'

module.exports = React.createClass

  propTypes:

    onSubmit: React.PropTypes.func.isRequired
    buttonText: React.PropTypes.string.isRequired

  getInitialState: ->

    email: ''
    password: ''

  render: ->

    <Col md={ 4 } mdOffset={ 3 } lg={ 4 } lgOffset={ 4 } sm={ 6 } smOffset={ 3 }>
      <h1>&nbsp;</h1>
      <form onSubmit={ @_onSubmit }>
        <Input
          type='email'
          placeholder='Email address...'
          onChange={ @_onChange.bind @, 'email' } />
        <Input
          type='password'
          placeholder='Password...'
          onChange={ @_onChange.bind @, 'password'} />
        <Button type='submit' variant='primary' block>
          { @props.buttonText }
        </Button>
      </form>
    </Col>

  _onChange: (key, e) ->

    @state[key] = e.target.value
    @setState @state

  _onSubmit: (e) ->

    e.preventDefault()

    @props.onSubmit @state.email, @state.password
