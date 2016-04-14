React = require 'react'
{ Row, Col } = require 'react-bootstrap'

# Main render Method
# ------------------------------------------------------------------------------

Article = (props, context) ->

  <Row>
    <Col xs={ 12 } className='articleSummary'>
      <div className='articleTitle'>
        { props.article?.title }
      </div>
      <span className='text-muted articlePreview'>
        { props.article.summary }
      </span>
    </Col>
  </Row>

# Component metadata
# ------------------------------------------------------------------------------

Article.propTypes =

  article: React.PropTypes.object.isRequired

module.exports = Article
