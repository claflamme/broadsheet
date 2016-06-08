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
  user: state.auth.user
  showNewSub: state.modals.showNewSub
  reader: state.reader

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    unless @props.token
      @context.router.replace '/login'

    @props.dispatch AuthActions.fetchUser()

  render: ->

    unless @props.token
      return null

    childProps = currentArticle: @props.reader.doc

    <Grid fluid className='dashboardGrid'>
      <Row>
        <Col xs={ 2 } className='subscriptions dashboardCol'>
          <Subscriptions
            subscriptions={ @props.subscriptions }
            showNewSub={ @props.showNewSub }
            user={ @props.user }
            dispatch={ @props.dispatch } />
        </Col>
        <Col xs={ 4 } className='articleListCol dashboardCol'>
          { React.cloneElement @props.children, childProps }
        </Col>
        <Col xs={ 6 } className='articleContent dashboardCol'>
          <ArticleReader reader={ @props.reader } />
        </Col>
      </Row>
    </Grid>
