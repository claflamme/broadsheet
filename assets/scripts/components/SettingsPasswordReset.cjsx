React = require 'react'
{ Form, FormGroup, FormControl, Col, ControlLabel, Button } = require 'react-bootstrap'
_ = require 'lodash'

api = require '../api'

module.exports = SettingsPasswordReset = React.createClass

  propTypes:

    dispatch: React.PropTypes.func.isRequired

  getInitialState: ->

    currentPass: ''
    newPass: ''
    saving: false
    saved: false
    err: null

  render: ->

    <Form horizontal onSubmit={ @setPassword }>
      <FormGroup>
        <Col componentClass={ ControlLabel } sm={ 2 }>
          Current Password
        </Col>
        <Col sm={ 4 }>
          <FormControl
            type='password'
            onChange={ @onChange.bind @, 'currentPass' } />
        </Col>
      </FormGroup>
      <FormGroup>
        <Col componentClass={ ControlLabel } sm={ 2 }>
          New Password
        </Col>
        <Col sm={ 4 }>
          <FormControl
            type='password'
            onChange={ @onChange.bind @, 'newPass' } />
        </Col>
      </FormGroup>
      <FormGroup>
        <Col smOffset={ 2 } sm={ 2 }>
          <Button type='submit' bsStyle='primary' disabled={ @state.saving }>
            Save password
          </Button>
        </Col>
      </FormGroup>
      <FormGroup>
        <Col smOffset={ 2 } sm={ 2 }>
          { @renderMessage() }
        </Col>
      </FormGroup>
    </Form>

  renderMessage: ->

    console.log @state

    unless @state.saved or @state.err
      return

    if @state.err
      return <strong className='text-danger'>{ @state.err.message }</strong>

    if @state.saved
      return <strong className='text-success'>Great success!</strong>

  onChange: (key, e) ->

    newState = saved: false
    newState[key] = e.target.value

    @setState newState

  setPassword: (e) ->

    e.preventDefault()

    if @state.saving
      return

    request =
      url: '/api/auth/password'
      method: 'PATCH'
      body:
        currentPassword: @state.currentPass
        newPassword: @state.newPass

    @setState saving: true, =>
      api.send request, (err, res) =>
        @setState saving: false, saved: true, err: err
