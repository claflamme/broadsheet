React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'
{ Link } = require 'react-router'
AuthActions = require '../actions/AuthActions'
Auth = require '../components/Auth'

mapStateToProps = (state) ->

  token: state.auth.token
  loading: state.auth.loading
  emailSent: state.auth.emailSent

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillReceiveProps: (nextProps) ->

    if nextProps.token
      @context.router.push '/'

  render: ->

    if @props.emailSent
      return <p>Check your email!</p>

    <Grid>
      <Row>
        <Auth
          onSubmit={ @_onSubmit }
          buttonText='Register'
          loading={ @props.loading } />
      </Row>
      <Row>
        <Col xs={ 12 } className='text-center'>
          <h1></h1>
          <Link to='login'>Log in</Link>
        </Col>
      </Row>
    </Grid>

  _onSubmit: (email, password) ->

    if @props.loading
      return

    @props.dispatch AuthActions.signUp email, password
