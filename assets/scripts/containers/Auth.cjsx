React = require 'react'
{ Grid, Row, Col, Panel, Input, Button} = require 'react-bootstrap'
{ connect } = require 'react-redux'
{ Link } = require 'react-router'
AuthActions = require '../actions/AuthActions'
EmailServices = require '../components/EmailServices'

mapStateToProps = (state) ->

  token: state.auth.token
  loading: state.auth.loading
  emailSent: state.auth.emailSent

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  getInitialState: ->

    email: ''

  componentWillReceiveProps: (nextProps) ->

    if nextProps.token
      @context.router.push '/'

  render: ->

    if @props.emailSent
      return <EmailServices />

    <Grid>
      <Row>
        <Col md={ 4 } mdOffset={ 3 } lg={ 4 } lgOffset={ 4 } sm={ 6 } smOffset={ 3 }>
          <h1>&nbsp;</h1>
          <h1 className='text-center'>Log in or Sign up</h1>
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
              Log in / Sign up
            </Button>
          </form>
        </Col>
      </Row>
    </Grid>

  _onChange: (key, e) ->

    @state[key] = e.target.value
    @setState @state

  _onSubmit: (e) ->

    e.preventDefault()

    if @props.loading
      return

    @props.dispatch AuthActions.signIn @state.email
