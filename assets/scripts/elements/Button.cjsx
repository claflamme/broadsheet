React = require 'react'

Button = (props, context) ->

  classNamesList = ['button', props.className]

  if props.variant
    classNamesList.push props.variant

  if props.block
    classNamesList.push 'block'

  <button
    {...props}
    className={ classNamesList.join ' ' }>
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
  className: ''

module.exports = Button
