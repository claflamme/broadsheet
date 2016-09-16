React = require 'react'
{ Link } = require 'react-router'
{ DropdownButton, MenuItem } = require 'react-bootstrap'

UserBadge = (props) ->

  <div className='user-badge'>
    <DropdownButton
      id='user-badge'
      noCaret
      title={ renderTitle(props.title) }
      bsStyle='link'>
      <MenuItem href='/logout'>
        <i className='fa fa-fw fa-sign-out'></i>
        <span>Log Out</span>
      </MenuItem>
    </DropdownButton>
  </div>

UserBadge.propTypes =
  title: React.PropTypes.string

renderTitle = (title) ->

  <div>
    { title or '' }
    <i className='fa fa-chevron-down pull-right'></i>
  </div>

module.exports = UserBadge
