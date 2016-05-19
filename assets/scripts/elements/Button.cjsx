React = require 'react'
BaseElement = require './BaseElement'

Button = (props, context) ->

  classList = ['button']

  if props.variant
    classList.push props.variant

  if props.block
    classList.push 'block'

  <BaseElement {...props} nodeType='button' classList={ classList }>
    { props.children }
  </BaseElement>

Button.propTypes =

  onClick: React.PropTypes.func
  variant: React.PropTypes.string
  block: React.PropTypes.bool
  type: React.PropTypes.string

Button.defaultProps =

  onClick: ->
  variant: null
  block: false
  type: 'button'
  className: ''

module.exports = Button
