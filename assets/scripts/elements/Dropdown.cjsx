React = require 'react'
BaseElement = require './BaseElement'

Dropdown = (props, context) ->

  classList = ['dropdown-list']

  <BaseElement nodeType='ul' classList={ classList }>
    { props.children }
  </BaseElement>

module.exports = Dropdown
