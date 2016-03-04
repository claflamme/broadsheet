React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'
AuthActions = require '../actions/AuthActions'
Subscriptions = require '../components/Subscriptions'

mapStateToProps = (state) ->

  subscriptions: state.subscriptions
  token: state.auth.token

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    if not @props.token
      @context.router.replace '/login'

  render: ->

    <Grid fluid>
      <Row>
        <Col xs={ 3 }>
          <Subscriptions
            subscriptions={ @props.subscriptions }
            dispatch={ @props.dispatch } />
        </Col>
      </Row>
    </Grid>
