React = require 'react'
{ Grid, Row, Col, Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
AuthActions = require '../actions/AuthActions'
ArticleActions = require '../actions/ArticleActions'
Subscriptions = require '../components/Subscriptions'
ArticleReader = require '../components/ArticleReader'

mapStateToProps = (state) -> state

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    unless @props.auth.token
      return @context.router.replace '/login'

    @props.dispatch AuthActions.fetchUser()

  render: ->

    childProps =
      dispatch: @props.dispatch
      articles: @props.articles
      auth: @props.auth
      modals: @props.modals
      reader: @props.reader
      subscriptions: @props.subscriptions

    # Prevent any "flicker" when redirecting to login screen.
    unless @props.auth.token
      return null

    React.cloneElement @props.children, childProps
