React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Grid, Row, Col, Navbar, Nav, NavItem } = require 'react-bootstrap'

FeedTitleBar = require './FeedTitleBar'
UserBadge = require './UserBadge'

AppNav = (props) ->

  title = 'All Subscriptions'
  activeSub = props.subscriptions.activeSubscription

  if activeSub
    title = activeSub?.customTitle or activeSub?.feed.title

  titleBarProps =
    title: title
    dispatch: props.dispatch
    showControls: props.subscriptions.activeSubscription?
    subscription: props.subscriptions.activeSubscription
    showEditSub: props.modals.visibility.subscriptionEdit
    showDeleteSub: props.modals.visibility.subscriptionDelete

  el Navbar, fluid: true, className: 'app-nav',
    el Row, null,
      el Col, xs: 12, sm: 3, lg: 2,
        el 'h4', className: 'logo',
          'Broadsheet'
      el Col, xs: 12, sm: 7, lg: 4,
        el FeedTitleBar, titleBarProps
      el Col, xs: 12, sm: 2, lg: 6,
        el UserBadge, title: props.user?.email

AppNav.propTypes =
  subTitle: pt.string
  dispatch: pt.func
  auth: pt.object
  articles: pt.object
  modals: pt.object
  reader: pt.object
  subscriptions: pt.object

module.exports = AppNav
