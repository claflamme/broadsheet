React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Grid, Row, Col, Navbar, Nav, NavItem } = require 'react-bootstrap'

FeedTitleBar = require './FeedTitleBar'
UserBadge = require './UserBadge'

toggleMobileMenu = (e) ->
  document.body.classList.toggle 'show-mobile-menu'

Nav = (props) ->
  title = 'All Subscriptions'
  activeSub = props.subscriptions.docs.find (sub) =>
    sub.feed._id is props.activeFeedId

  titleBarProps =
    title: activeSub?.customTitle or activeSub?.feed.title or title
    dispatch: props.dispatch
    showControls: activeSub?
    subscription: activeSub
    showEditSub: props.modals.visibility.subscriptionEdit
    showDeleteSub: props.modals.visibility.subscriptionDelete

  el Navbar, fluid: true, className: 'app-nav',
    el Row, null,
      # --- Broadsheet logo & burger icon
      el Col, xs: 6, sm: 3, lg: 2,
        el 'i', className: 'fa fa-bars mobile-menu-button', onClick: toggleMobileMenu
        el 'i', className: 'fa fa-times mobile-menu-button', onClick: toggleMobileMenu
        el 'h4', className: 'logo',
          'Broadsheet'
      # --- Feed title & controls
      el Col, xs: 12, sm: 7, lg: 4,
        el FeedTitleBar, titleBarProps
      # --- User options dropdown
      el Col, xs: 6, sm: 2, lg: 6, className: 'user-badge-col',
        el UserBadge, title: props.user?.email

Nav.propTypes =
  activeFeedId: pt.string
  subTitle: pt.string
  dispatch: pt.func
  auth: pt.object
  articles: pt.object
  modals: pt.object
  reader: pt.object
  subscriptions: pt.object

module.exports = Nav
