import React, { createElement as el } from 'react'
import PT from 'prop-types'
import { Button } from 'react-bootstrap'

ZeroState = (props) ->
  el 'div', className: 'text-center',
    el 'div', className: 'h1', null,
      ' '
    el 'h2', null,
      'Hey, alright!'
    el 'p', className: 'lead',
      "Let's start by adding an RSS subscription."
    el Button, {
      bsStyle: 'primary'
      bsSize: 'lg'
      className: 'mt-1'
      onClick: props.onClick
    },
      el 'span', null,
        "Add Subscription "
        el 'i', className: 'fa fa-plus'

ZeroState.propTypes =
  onClick: PT.func

ZeroState.defaultProps =
  onClick: ->

module.exports = ZeroState
