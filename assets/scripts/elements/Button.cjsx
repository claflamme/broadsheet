React = require 'react'
BaseElement = require './BaseElement'

Button = (props, context) ->

  classList = ['button']

  if props.variant
    classList.push props.variant

  if props.block
    classList.push 'block'

  if props.loading
    classList.push 'loading'

  <BaseElement {...props} nodeType='button' disabled={ props.loading } classList={ classList }>
    { props.children }
  </BaseElement>

Button.propTypes =
  onClick: React.PropTypes.func
  variant: React.PropTypes.string
  block: React.PropTypes.bool
  loading: React.PropTypes.bool

Button.defaultProps =
  onClick: ->
  variant: null
  block: false
  loading: false

module.exports = Button
