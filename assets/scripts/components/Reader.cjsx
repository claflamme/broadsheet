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
      <Col xs={ 12 } sm={ 3 } lg={ 2 } className='subscriptions dashboard-col'>
        <Subscriptions
          subscriptions={ props.subscriptions }
          showNewSub={ props.modals.showNewSub }
          newSubError={ props.modals.newSubError }
          user={ props.auth.user }
          dispatch={ props.dispatch } />
      </Col>
      <Col xs={ 12 } sm={ 9 } lg={ 4 } className='article-list-col dashboard-col'>
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
      <Col xs={ 12 } lg={ 6 } className='articleContent dashboard-col'>
        <ArticleReader
          show={ props.reader.showMobileReader }
          onHide={ props.hideReader }
          reader={ props.reader }
          subscriptions={ props.subscriptions  } />
      </Col>
    </Row>
  </Grid>

Reader.propTypes =
  title: React.PropTypes.string
  loadMoreArticles: React.PropTypes.func
  onArticleClick: React.PropTypes.func
  hideReader: React.PropTypes.func
  showControls: React.PropTypes.bool
  subscription: React.PropTypes.object

module.exports = Reader
