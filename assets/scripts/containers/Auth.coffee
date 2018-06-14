React = require 'react'
{ Component } = React
el = React.createElement
pt = require 'prop-types'
{ Grid, Row, Col, Panel, FormControl, FormGroup, Button, Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
{ Link } = require 'react-router'

AuthActions = require '../actions/AuthActions'

class Auth extends Component

  @propTypes:
    dispatch: pt.func
    token: pt.string
    loading: pt.bool
    emailSent: pt.bool

  @contextTypes:
    router: pt.object

  constructor: (props) ->
    super props

    @state =
      email: ''

  componentWillReceiveProps: (nextProps) ->
    if nextProps.token
      @context.router.push '/'

  _onEmailChange: (e) =>
    @setState email: e.target.value

  _onFormSubmit: (e) =>
    e.preventDefault()

    if @props.loading
      return

    @props.dispatch AuthActions.signIn @state.email

  renderAuthForm: (show) ->
    unless show
      return

    formControlProps =
      type: 'email'
      autoFocus: true
      placeholder: 'Email address...'
      onChange: @_onEmailChange
      disabled: @props.loading

    buttonProps =
      type: 'submit'
      bsStyle: 'primary'
      bsSize: 'large'
      className: if @props.loading then 'loading' else ''
      disabled: @props.loading
      block: true

    el 'form', onSubmit: @_onFormSubmit,
      el FormGroup, bsSize: 'large',
        el FormControl, formControlProps
      el Button, buttonProps,
        "Log in / Sign up"
        el 'i', className: 'fa fa-fw fa-lock'

  renderConfirmation: (show) ->
    unless show
      return

    el Panel, className: 'text-center',
      el 'h3', null,
        "Nice, thanks"
        el 'i', className: 'fa fa-fw fa-thumbs-up'
      el 'p', null,
        "Check your email, you should get a login link any second now."

  render: ->
    el 'div', null,
      el Navbar, fluid: true, className: 'app-nav',
        el Row, null,
          el Col, xs: 12, className: 'text-center',
            el 'h4', className: 'logo',
              'Broadsheet'
      el Grid, className: 'auth-prompt',
        el Row, null,
          el Col, md: 4, mdOffset: 3, lg: 4, lgOffset: 4, sm: 6, smOffset: 3,
            el 'div', className: 'text-center',
              el 'h1', null,
                el 'i', className: 'fa fa-user fa-2x'
              el 'h3', className: 'text-center',
                "Log in or Sign up"
              el 'p', null,
                "Enter your email address to sign in. If you don't have an account, we'll create one for you."
              el 'h4', null,
                " "
            @renderAuthForm not @props.emailSent
            @renderConfirmation @props.emailSent

mapStateToProps = (state) ->
  token: state.auth.token
  loading: state.auth.loading
  emailSent: state.auth.emailSent

module.exports = connect(mapStateToProps) Auth
