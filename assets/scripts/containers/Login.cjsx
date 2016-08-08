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
        <Auth onSubmit={ @_onSubmit } buttonText='Log in' />
      </Row>
      <Row>
        <Col xs={ 12 } className='text-center'>
          <h1></h1>
          <Link to='register'>Create an account</Link>
        </Col>
      </Row>
    </Grid>

  _onSubmit: (email) ->

    if @props.loading
      return

    @props.dispatch AuthActions.signIn email
