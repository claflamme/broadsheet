React = require 'react'
{ Row, Col } = require 'react-bootstrap'
moment = require 'moment'

module.exports = React.createClass

  propTypes:

    article: React.PropTypes.object.isRequired
    subscription: React.PropTypes.object.isRequired

  render: ->

    <Row>
      <Col xs={ 1 } className='articleSubscriptionTitle'>
        <span className='text-muted'>
          { @props.subscription.customTitle or @props.subscription.feed.title }
        </span>
      </Col>
      <Col xs={ 10 } className='articleSummary'>
        <span className='articleTitle'>
          { @props.article.title }
        </span>
        &nbsp;
        <span className='text-muted articlePreview'>
          { @props.article.summary }
        </span>
      </Col>
      <Col xs={ 1 } className='text-muted'>
        <span>{ moment(@props.article.publishedAt).fromNow true }</span>
      </Col>
    </Row>
