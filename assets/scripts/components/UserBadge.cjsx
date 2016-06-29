React = require 'react'
{ DropdownButton, MenuItem } = require 'react-bootstrap'

UserBadge = (props) ->

  <DropdownButton
    id='user-badge'
    title={ props.title or '' }
    bsStyle='link'
    className='user-badge'>
    <MenuItem href='/settings'>Account Settings</MenuItem>
    <MenuItem href='/logout'>Log Out</MenuItem>
  </DropdownButton>

UserBadge.propTypes =
  title: React.PropTypes.string

module.exports = UserBadge
