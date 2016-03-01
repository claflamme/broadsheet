React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'

selectState = (state) -> return state

module.exports = connect(selectState) React.createClass

  render: ->

    <Grid fluid>
      <Row>
        <Col xs={ 12 }>
          <p>Hello, friends.</p>
        </Col>
      </Row>
    </Grid>
