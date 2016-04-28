React = require 'react'

Button = (props, context) ->

  classNames = ['button']

  if props.variant
    classNames.push props.variant

  if props.block
    classNames.push 'block'

  <button
    className={ classNames.join ' ' }
    onClick={ props.onClick }
    type={ props.type }>
    { props.children }
  </button>

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

module.exports = Button
