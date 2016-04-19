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
  articleBody: state.reader.body
  article: state.reader.article
  articleVisible: state.reader.visible

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    unless @props.token
      @context.router.replace '/login'

  render: ->

    unless @props.token
      return null

    childProps = currentArticle: @props.article

    <Grid fluid className='dashboardGrid'>
      <Row>
        <Col xs={ 2 } className='dashboardCol subscriptions'>
          <Subscriptions
            subscriptions={ @props.subscriptions }
            showNewSub={ @props.showNewSub }
            dispatch={ @props.dispatch } />
        </Col>
        <Col xs={ 4 } className='dashboardCol articleListCol'>
          { React.cloneElement @props.children, childProps }
        </Col>
        <Col xs={ 6 } className='dashboardCol articleContent'>
          <ArticleReader
            article={ @props.article }
            articleBody={ @props.articleBody } />
        </Col>
      </Row>
    </Grid>

  _hideReader: ->

    @props.dispatch ArticleActions.hideContent()
