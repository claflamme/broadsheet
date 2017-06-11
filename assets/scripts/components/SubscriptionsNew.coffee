React = require 'react'
{ Component } = React
pt = require 'prop-types'
el = React.createElement
{ Modal, Button, FormControl, Alert } = require 'react-bootstrap'

module.exports = class SubscriptionsNew extends Component

  @propTypes:
    show: pt.bool.isRequired
    hasError: pt.bool.isRequired
    onHide: pt.func.isRequired
    onSubmit: pt.func.isRequired
    loading: pt.bool.isRequired

  constructor: (props) ->
    super props

    @state =
      url: ''

  _renderError: (props) ->
    unless props.hasError
      return

    el Alert, bsStyle: 'danger',
      "Uh oh, I don't think that's a valid RSS feed."

  _onChange: (e) =>
    @setState url: e.target.value

  _reset: =>
    @setState url: ''

  _submit: (e) =>
    e.preventDefault()

    @props.onSubmit @state

  render: ->
    urlFieldProps =
      type: 'text'
      autoFocus: true
      placeholder: 'http://examplesite.com/rss.xml'
      value: @state.url
      onChange: @_onChange

    el Modal, show: @props.show, onHide: @props.onHide, onExited: @_reset,
      el 'form', onSubmit: @_submit,
        el Modal.Header, null,
          el Modal.Title, null,
            "Add a subscription"
        el Modal.Body, null,
          @_renderError @props
          el FormControl, urlFieldProps
        el Modal.Footer, null,
          el Button, bsStyle: 'link', onClick: @props.onHide,
            "Cancel"
          el Button, bsStyle: 'primary', type: 'submit',
            "Add"
