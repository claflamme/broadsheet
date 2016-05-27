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

  e.target.classList.add 'expanded'

  bodyClickHandler = ->
    document.body.removeEventListener 'click', bodyClickHandler
    document.querySelectorAll('.user-badge')[0].classList.remove 'expanded'

  document.body.addEventListener 'click', bodyClickHandler

module.exports = Badge
