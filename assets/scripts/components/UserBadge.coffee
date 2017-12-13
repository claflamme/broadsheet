React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Link } = require 'react-router'
{ DropdownButton, MenuItem } = require 'react-bootstrap'

UserBadge = (props) ->
  dropdownButtonProps =
    id: 'user-badge'
    noCaret: true
    title: renderTitle props.title
    bsStyle: 'link'

  el 'span', className: 'user-badge pull-right',
    el DropdownButton, dropdownButtonProps,
      el MenuItem, header: true,
        props.title
      el MenuItem, href: '/logout',
        el 'span', {},
          'Log Out'

UserBadge.propTypes =
  title: pt.string

renderTitle = (title) ->
  el 'div', {},
    'Settings'
    el 'i', className: 'fa fa-chevron-down pull-right'

module.exports = UserBadge
