React = require 'react'
{ Grid, Row, Col, Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
AuthActions = require '../actions/AuthActions'
ArticleActions = require '../actions/ArticleActions'
Subscriptions = require '../components/Subscriptions'
ArticleReader = require '../components/ArticleReader'

mapStateToProps = (state) ->

  subscriptions: state.subscriptions
  token: state.auth.token
  showNewSub: state.modals.showNewSub
  reader: state.reader

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    unless @props.token
      @context.router.replace '/login'

  render: ->

    unless @props.token
      return null

    childProps = currentArticle: @props.reader.doc

    <Grid fluid className='dashboardGrid'>
      <Row>
        <Col xs={ 2 } className='dashboardCol subscriptions'>
          <Subscriptions
            subscriptions={ @props.subscriptions.docs }
            showNewSub={ @props.showNewSub }
            dispatch={ @props.dispatch } />
        </Col>
        <Col xs={ 4 } className='dashboardCol articleListCol'>
          { React.cloneElement @props.children, childProps }
        </Col>
        <Col xs={ 6 } className='dashboardCol articleContent'>
          <ArticleReader reader={ @props.reader } />
        </Col>
      </Row>
    </Grid>
