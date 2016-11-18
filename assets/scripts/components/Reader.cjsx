React = require 'react'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'
Subscriptions = require '../components/Subscriptions'
ArticleReader = require '../components/ArticleReader'
ArticleList = require '../components/ArticleList'
FeedTitleBar = require '../components/FeedTitleBar'

Reader = (props) ->

  <Grid fluid className='dashboardGrid'>
    <Row>
      <Col xs={ 2 } className='subscriptions dashboardCol'>
        <Subscriptions
          subscriptions={ props.subscriptions }
          showNewSub={ props.modals.showNewSub }
          newSubError={ props.modals.newSubError }
          user={ props.auth.user }
          dispatch={ props.dispatch } />
      </Col>
      <Col xs={ 4 } className='articleListCol dashboardCol'>
        <FeedTitleBar
          title={ props.title }
          dispatch={ props.dispatch }
          showControls={ props.showControls }
          subscription={ props.subscription }
          showEditSub={ props.modals.showEditSub }
          showDeleteSub={ props.modals.showDeleteSub } />
        <ArticleList
          loadMore={ props.loadMoreArticles }
          articles={ props.articles }
          currentArticle={ props.reader.doc }
          onClick={ props.onArticleClick } />
      </Col>
      <Col xs={ 6 } className='articleContent dashboardCol'>
        <ArticleReader
          reader={ props.reader }
          subscriptions={ props.subscriptions  } />
      </Col>
    </Row>
  </Grid>

Reader.propTypes =
  title: React.PropTypes.string
  loadMoreArticles: React.PropTypes.func
  onArticleClick: React.PropTypes.func
  showControls: React.PropTypes.bool
  subscription: React.PropTypes.object

module.exports = Reader
