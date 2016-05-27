React = require 'react'
BaseElement = require './BaseElement'
Dropdown = require './Dropdown'

Badge = (props, context) ->

  <BaseElement {...props} classList={ ['user-badge'] } onClick={ setExpanded }>
    <span>{ props.text }</span>
    <i className='fa fa-chevron-down'></i>
    <Dropdown>
      { props.children }
    </Dropdown>
  </BaseElement>

Badge.propTypes =
  text: React.PropTypes.string

setExpanded = (e) ->

  e.preventDefault()

  target = e.currentTarget
  classList = target.classList

  # One-time handler that gets removed after firing
  closeDropdown = (closeEvent) ->
    document.body.removeEventListener 'click', closeDropdown
    classList.remove 'opened'

  target.classList.add 'opened'
  document.body.addEventListener 'click', closeDropdown

module.exports = Badge
