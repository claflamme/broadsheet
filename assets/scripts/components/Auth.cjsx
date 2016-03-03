React = require 'react'
{ Grid, Row, Col, Panel, Input, Button } = require 'react-bootstrap'

module.exports = React.createClass

  propTypes:

    onSubmit: React.PropTypes.func.isRequired

  getInitialState: ->

    email: ''
    password: ''

  render: ->

    <Col md={ 4 } mdOffset={ 3 } lg={ 4 } lgOffset={ 4 } sm={ 6 } smOffset={ 3 }>
      <img className='logo auth' src='logo.png' />
      <form onSubmit={ @_onSubmit }>
        <Input
          type='email'
          placeholder='Email address...'
          onChange={ @_onChange.bind @, 'email' } />
        <Input
          type='password'
          placeholder='Password...'
          onChange={ @_onChange.bind @, 'password'} />
        <Button type='submit' bsStyle='primary' block disabled={ @props.loading }>
          Log in
        </Button>
      </form>
    </Col>

  _onChange: (key, e) ->

    @state[key] = e.target.value
    @setState @state

  _onSubmit: (e) ->

    e.preventDefault()

    @props.onSubmit @state.email, @state.password
