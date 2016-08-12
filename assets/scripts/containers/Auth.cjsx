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

    <Grid>
      <Row>
        <Col md={ 4 } mdOffset={ 3 } lg={ 4 } lgOffset={ 4 } sm={ 6 } smOffset={ 3 }>
          <h1>&nbsp;</h1>
          <div className='text-center'>
            <h1>
              <i className='fa fa-user fa-2x'></i>
            </h1>
            <h3 className='text-center'>Log in or Sign up</h3>
            <p>Enter your email address to sign in. If you don't have an account, we'll create one for you.</p>
            <h4>&nbsp;</h4>
          </div>
          { @renderAuthForm not @props.emailSent }
          { @renderConfirmation @props.emailSent }
        </Col>
      </Row>
    </Grid>

  renderAuthForm: (show) ->

    unless show
      return

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
        Log in / Sign up <i className='fa fa-fw fa-lock'></i>
      </Button>
    </form>

  renderConfirmation: (show) ->

    unless show
      return

    <Panel className='text-center'>
      <h3>
        Nice, thanks <i className='fa fa-fw fa-thumbs-up'></i>
      </h3>
      <p>Check your email, you should get a login link any second now.</p>
    </Panel>

  _onChange: (key, e) ->

    @state[key] = e.target.value
    @setState @state

  _onSubmit: (e) ->

    e.preventDefault()

    if @props.loading
      return

    @props.dispatch AuthActions.signIn @state.email
