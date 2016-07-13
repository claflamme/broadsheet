React = require 'react'
{ Form, FormGroup, FormControl, Col, ControlLabel, Button } = require 'react-bootstrap'
api = require '../api'

module.exports = SettingsPasswordReset = React.createClass

  propTypes:
    dispatch: React.PropTypes.func.isRequired

  getInitialState: ->

    currentPassword: ''
    newPassword: ''
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
          <FormControl type='password' onChange={ @setCurrentPassword } />
        </Col>
      </FormGroup>
      <FormGroup>
        <Col componentClass={ ControlLabel } sm={ 2 }>
          New Password
        </Col>
        <Col sm={ 4 }>
          <FormControl type='password' onChange={ @setNewPassword } />
        </Col>
      </FormGroup>
      <FormGroup>
        <Col smOffset={ 2 } sm={ 2 }>
          <Button type='submit' bsStyle='primary' disabled={ @state.saving }>
            Save password
          </Button>
        </Col>
      </FormGroup>
    </Form>

  setCurrentPassword: (e) ->

    @setState currentPassword: e.target.value

  setNewPassword: (e) ->

    @setState newPassword: e.target.value

  setPassword: (e) ->

    e.preventDefault()

    if @state.saving
      return

    request =
      url: '/api/auth/password'
      method: 'PATCH'
      body:
        currentPassword: @state.currentPassword
        newPassword: @state.newPassword

    @setState saving: true, =>
      api.send request, (err, res) =>
        @setState saving: false, saved: not err
