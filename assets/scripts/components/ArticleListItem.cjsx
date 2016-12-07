React = require 'react'
{ Row, Col } = require 'react-bootstrap'
{ Link } = require 'react-router'

Article = (props, context) ->

  <Row>
    <Col xs={ 12 } className='article-summary'>
      <div
        className='article-title'
        dangerouslySetInnerHTML={{ __html: props.article?.title }}>
      </div>
      <div>
        { renderSubscriptionName props.article.subscription }
      </div>
      <span
        className='text-muted article-preview'
        dangerouslySetInnerHTML={{ __html: props.article.summary }}>
      </span>
    </Col>
  </Row>

Article.propTypes =

  article: React.PropTypes.object.isRequired

renderSubscriptionName = (subscription) ->

  unless subscription
    return

  <small className='text-muted' style={{textTransform:'uppercase'}}>
    { subscription.customTitle or subscription.feed.title }
  </small>

module.exports = Article
