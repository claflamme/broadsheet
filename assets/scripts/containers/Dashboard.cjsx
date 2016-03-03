React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'

selectState = (state) -> return state

module.exports = connect(selectState) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    if not @props.auth.token
      @context.router.replace '/login'

  render: ->

    <Grid fluid>
      <Row>
        <Col xs={ 12 }>
          <p>Hello, friends.</p>
        </Col>
      </Row>
    </Grid>
