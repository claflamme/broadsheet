React = require 'react'

FeedTitle = (props, context) ->

  <div className='feedTitleBar'>
    <h3 className='feedTitle'>{ props.title }</h3>
  </div>

FeedTitle.propTypes =
  title: React.PropTypes.string.isRequired

module.exports = FeedTitle
