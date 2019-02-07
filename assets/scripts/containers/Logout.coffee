Cookies = require 'js-cookie'
React = require 'react'
{ Component } = React

module.exports = class Logout extends Component

  componentWillMount: ->
    Cookies.remove 'token'
    window.location.href = '/authenticate'

  render: ->
    null
