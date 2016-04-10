React = require 'react'
{ Grid, Row, Col, Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
AuthActions = require '../actions/AuthActions'
ArticleActions = require '../actions/ArticleActions'
Subscriptions = require '../components/Subscriptions'

mapStateToProps = (state) ->

  subscriptions: state.subscriptions
  token: state.auth.token
  showNewSubscriptionPrompt: state.modals.showNewSubscriptionPrompt
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

    <Grid fluid className="dashboardGrid #{ if @props.articleVisible then 'articleOpen' }">
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
        <Col xs={ 5 } className='dashboardCol articleContent'>
          <span className='closeArticleContent' onClick={ @_hideReader }>
            <div className='closeButton'>></div>
          </span>
          <div className='articleWrapper'>
            <div className='articleBody'>
              <h1>
                <a href={ @props.article?.url or '' } target='_blank'>
                  { @props.article?.title or '' }
                </a>
              </h1>
              <div dangerouslySetInnerHTML={ { __html: @props.articleBody } }></div>
            </div>
          </div>
        </Col>
      </Row>
    </Grid>

  _hideReader: ->

    @props.dispatch ArticleActions.hideContent()
