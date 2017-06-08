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

  el 'div', className: 'user-badge',
    el DropdownButton, dropdownButtonProps,
      el MenuItem, href: '/logout',
        el 'i', className: 'fa fa-fw fa-sign-out'
        el 'span', {},
          'Log Out'

UserBadge.propTypes =
  title: pt.string

renderTitle = (title) ->
  el 'div', {},
    title or ''
    el 'i', className: 'fa fa-chevron-down pull-right'

module.exports = UserBadge
