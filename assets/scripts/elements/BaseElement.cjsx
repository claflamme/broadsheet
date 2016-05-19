React = require 'react'

BaseElement = (props, context) ->

  newProps = Object.assign {}, props,
    className: buildClassName props

  React.createElement props.nodeType, newProps, props.children

BaseElement.propTypes =
  nodeType: React.PropTypes.string
  classList: React.PropTypes.array
  classMap: React.PropTypes.object

BaseElement.defaultProps =
  nodeType: 'div'
  classList: []
  classMap: {}

buildClassName = (props) ->

  classList = props.classList

  if props.className
    classList.push props.className

  for name, isIncluded of props.classMap
    if isIncluded is true
      classList.push name

  return classList.join ' '

module.exports = BaseElement
