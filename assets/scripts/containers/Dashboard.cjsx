React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
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

    <Grid>
      <h4>&nbsp;</h4>
      <Row>
        <Col xs={ 3 }>
          <Subscriptions
            subscriptions={ @props.subscriptions }
            showNewSubscriptionPrompt={ @props.showNewSubscriptionPrompt }
            dispatch={ @props.dispatch } />
        </Col>
        <Col xs={ 9 }>
          { @props.children }
        </Col>
      </Row>
    </Grid>
