React = require 'react'
{ Component } = React

module.exports = class Logout extends Component

  componentWillMount: ->
    localStorage.clear()
    window.location.href = '/authenticate'

  render: ->
    null
