React = require 'react'
moment = require 'moment'

module.exports = React.createClass

  propTypes:

    article: React.PropTypes.object.isRequired
    subscription: React.PropTypes.object.isRequired

  render: ->

    <div>
      <a href='' className='articleTitle'>
        { @props.article.title }
      </a>
      <div className='text-muted'>
        <small>
          { @props.subscription.customTitle or @props.subscription.feed.title }
        </small>
        <span>&nbsp;&bull;&nbsp;</span>
        <small>
          { moment(@props.article.publishedAt).fromNow() }
        </small>
      </div>
    </div>
