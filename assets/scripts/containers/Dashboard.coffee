React = require 'react'
{ Component } = React
el = React.createElement
{ connect } = require 'react-redux'
{ Grid, Row, Col } = require 'react-bootstrap'
pick = require 'lodash/pick'
fromPairs = require 'lodash/fromPairs'

Loader = require '../components/Loader'
AppNav = require '../components/AppNav'
SubscriptionList = require '../components/SubscriptionList'
SubscriptionNewWindow = require '../components/SubscriptionNewWindow'
ArticleReader = require '../components/ArticleReader'
ZeroState = require '../components/ZeroState'
AuthActions = require '../actions/AuthActions'
SubscriptionActions = require '../actions/SubscriptionActions'
ModalActions = require '../actions/ModalActions'
ArticleActions = require '../actions/ArticleActions'

class Dashboard extends Component

  @contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->
    unless @props.auth.token
      return @context.router.replace '/authenticate'

    @props.dispatch AuthActions.fetchUser()
    @props.dispatch SubscriptionActions.fetchSubscriptionList()

  _addSubscription: (form) =>
    @props.dispatch SubscriptionActions.add form.url

  _showNewSubscription: =>
    @props.dispatch ModalActions.setVisibility subscriptionNew: true

  _hideNewSubscription: =>
    @props.dispatch ModalActions.setVisibility subscriptionNew: false

  _hideReader: =>
    @props.dispatch ArticleActions.hideReader()

  render: ->
    # Prevent any "flicker" when redirecting to login screen.
    unless @props.auth.token
      return null

    # Any child components of this route handler will receive these as props.
    childProps = pick @props, [
      'dispatch'
      'auth'
      'articles'
      'modals'
      'reader'
      'subscriptions'
    ]

    childProps.user = @props.auth.user
    childProps.subscriptions.active = @props.subscriptions.docs.find (sub) =>
      sub.feed._id is @props.params.feedId

    subscriptionsProps =
      subscriptions: @props.subscriptions.docs
      user: @props.auth.user
      dispatch: @props.dispatch

    subscriptionNewProps =
      show: @props.modals.visibility.subscriptionNew
      hasError: @props.modals.newSubError
      onHide: @_hideNewSubscription
      onSubmit: @_addSubscription
      loading: @props.subscriptions.ui.adding

    articleListProps =
      articles: @props.articles
      currentArticle: @props.reader.doc
      dispatch: @props.dispatch
      subscriptions: @props.subscriptions
      reader: @props.reader

    articleReaderProps =
      show: @props.reader.showMobileReader
      onHide: @_hideReader
      reader: @props.reader
      subscriptions: @props.subscriptions.docs

    el 'div', null,
      el AppNav, childProps
      el Grid, fluid: true, className: 'dashboardGrid',
        unless @props.subscriptions.fetched
          el Loader, show: true
        else if subscriptionsProps.subscriptions.length > 0
          el Row, className: 'height-100',
            el Col, xs: 12, sm: 3, lg: 2, className: 'subscriptions dashboard-col',
              el SubscriptionList, subscriptionsProps
            el Col, xs: 12, sm: 9, lg: 4, className: 'article-list-col dashboard-col',
              React.cloneElement @props.children, articleListProps
            el Col, xs: 12, lg: 6, className: 'article-display dashboard-col',
              el Loader, show: @props.reader.loading
              el ArticleReader, articleReaderProps
        else
          el Row, null,
            el Col, xs: 12,
              el ZeroState, onClick: @_showNewSubscription
      el SubscriptionNewWindow, subscriptionNewProps

module.exports = connect((state) -> state) Dashboard
