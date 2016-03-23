React = require 'react'
{ Grid, Row, Col, Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
AuthActions = require '../actions/AuthActions'
Subscriptions = require '../components/Subscriptions'

mapStateToProps = (state) ->

  subscriptions: state.subscriptions
  token: state.auth.token
  showNewSubscriptionPrompt: state.modals.showNewSubscriptionPrompt

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    if not @props.token
      @context.router.replace '/login'

  render: ->

    <Grid fluid className='dashboardGrid'>
      <Row>
        <Col xs={ 2 } className='dashboardCol subscriptions'>
          <Subscriptions
            subscriptions={ @props.subscriptions }
            showNewSubscriptionPrompt={ @props.showNewSubscriptionPrompt }
            dispatch={ @props.dispatch } />
        </Col>
        <Col xs={ 10 } className='dashboardCol articleListCol'>
          { @props.children }
        </Col>
      </Row>
    </Grid>
