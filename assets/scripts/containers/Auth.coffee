React = require 'react'
c = React.createElement
{ Grid, Row, Col, Panel, FormControl, FormGroup, Button} = require 'react-bootstrap'
{ connect } = require 'react-redux'
{ Link } = require 'react-router'
AuthActions = require '../actions/AuthActions'

mapStateToProps = (state) ->

  token: state.auth.token
  loading: state.auth.loading
  emailSent: state.auth.emailSent

module.exports = connect(mapStateToProps) React.createClass

  contextTypes:

    router: React.PropTypes.object

  getInitialState: ->

    email: ''

  componentWillReceiveProps: (nextProps) ->

    if nextProps.token
      @context.router.push '/'

  render: ->

    c Grid, { className: 'auth-prompt' },
      c Row, {},
        c Col, { md: 4, mdOffset: 3, lg: 4, lgOffset: 4, sm: 6, smOffset: 3 },
          c 'div', { className: 'text-center' },
            c 'h1', {},
              c 'i', { className: 'fa fa-user fa-2x' }
            c 'h3', { className: 'text-center' },
              "Log in or Sign up"
            c 'p', {},
              "Enter your email address to sign in. If you don't have an account, we'll create one for you."
            c 'h4', {},
              " "
          @renderAuthForm not @props.emailSent
          @renderConfirmation @props.emailSent

  renderAuthForm: (show) ->

    unless show
      return

    c 'form', { onSubmit: @_onSubmit },
      c FormGroup, { bsSize: 'large' },
        c FormControl, {
          type: 'email'
          autoFocus: true
          placeholder: 'Email address...'
          onChange: @_onChange.bind @, 'email'
        }
      c Button, {
        type: 'submit'
        bsStyle: 'primary'
        bsSize: 'large'
        className: if @props.loading then 'loading' else ''
        disabled: @props.loading
        block: true
      },
        "Log in / Sign up"
        c 'i', { className: 'fa fa-fw fa-lock' }

  renderConfirmation: (show) ->

    unless show
      return

    c Panel, { className: 'text-center' },
      c 'h3', {},
        "Nice, thanks"
        c 'i', { className: 'fa fa-fw fa-thumbs-up' }
      c 'p', {},
        "Check your email, you should get a login link any second now."

  _onChange: (key, e) ->

    @state[key] = e.target.value
    @setState @state

  _onSubmit: (e) ->

    e.preventDefault()

    if @props.loading
      return

    @props.dispatch AuthActions.signIn @state.email
