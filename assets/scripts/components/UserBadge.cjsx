React = require 'react'
{ Link } = require 'react-router'
{ DropdownButton, MenuItem } = require 'react-bootstrap'

UserBadge = (props) ->

  <DropdownButton
    id='user-badge'
    title={ props.title or '' }
    bsStyle='link'
    className='user-badge'>
    <MenuItem href='/settings'>
      <i className='fa fa-fw fa-gear'></i>
      <span>Settings</span>
    </MenuItem>
    <MenuItem href='/logout'>
      <i className='fa fa-fw fa-sign-out'></i>
      <span>Log Out</span>
    </MenuItem>
  </DropdownButton>

UserBadge.propTypes =
  title: React.PropTypes.string

module.exports = UserBadge
