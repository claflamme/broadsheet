React = require 'react'
BaseElement = require './BaseElement'

Badge = (props, context) ->

  <BaseElement {...props} classList={ ['userBadge'] }>
    <span>{ props.text }</span>
    <i className='fa fa-chevron-down'></i>
    { props.children }
  </BaseElement>

Badge.propTypes =
  text: React.PropTypes.string

module.exports = Badge
