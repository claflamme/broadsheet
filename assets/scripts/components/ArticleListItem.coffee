React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Row, Col } = require 'react-bootstrap'
{ Link } = require 'react-router'

renderSubscriptionName = (subscription) ->
  unless subscription
    return

  el 'small', className: 'text-muted', style: { textTransform:'uppercase' },
    subscription.customTitle or subscription.feed.title

ArticleListItem = (props, context) ->
  titleProps =
    className: 'article-title'
    dangerouslySetInnerHTML: { __html: props.article?.title }

  summaryProps =
    className: 'text-muted article-preview'
    dangerouslySetInnerHTML: { __html: props.article.summary }

  el Row, null,
    el Col, xs: 12, className: 'article-summary',
      el 'div', titleProps
      el 'div', null,
        renderSubscriptionName props.article.subscription
      el 'span', summaryProps

ArticleListItem.propTypes =
  article: pt.object.isRequired

module.exports = ArticleListItem
