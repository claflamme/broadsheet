React = require 'react'
{ Link } = require 'react-router'
{ Navbar, Nav, NavItem, Grid, Row, Col } = require 'react-bootstrap'
SettingsPasswordReset = require '../components/SettingsPasswordReset'

Settings = (props) ->

  <div>
    <Navbar>
      <Grid>
        <Row>
          <Col xs={ 12 }>
            <Navbar.Brand>
              <Link to='/'>
                <i className='fa fa-angle-left'></i>
                &nbsp;
                Back to Dashboard
              </Link>
            </Navbar.Brand>
          </Col>
        </Row>
      </Grid>
    </Navbar>
    <Grid>
      <Row>
        <Col xs={ 12 }>
          <SettingsPasswordReset dispatch={ props.dispatch } />
        </Col>
      </Row>
    </Grid>
  </div>

Settings.propTypes =
  dispatch: React.PropTypes.func.isRequired

module.exports = Settings
