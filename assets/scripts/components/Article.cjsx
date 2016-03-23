React = require 'react'
{ Row, Col } = require 'react-bootstrap'
moment = require 'moment'

module.exports = React.createClass

  propTypes:

    article: React.PropTypes.object.isRequired

  render: ->

    <Row>
      <Col xs={ 12 } className='articleSummary'>
        <span className='articleTitle'>
          { @props.article.title }
        </span>
        &nbsp;
        <span className='text-muted articlePreview'>
          { @props.article.summary }
        </span>
      </Col>
    </Row>
