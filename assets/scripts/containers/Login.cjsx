React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'
{ Link } = require 'react-router'
AuthActions = require '../actions/AuthActions'
Auth = require '../components/Auth'

mapStateToProps = (state) ->

  token: state.auth.token
  loading: state.auth.loading

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillReceiveProps: (nextProps) ->

    if nextProps.token
      @context.router.push '/'

  render: ->

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

  _onSubmit: (email, password) ->

    if @props.loading
      return

    @props.dispatch AuthActions.signIn email, password
