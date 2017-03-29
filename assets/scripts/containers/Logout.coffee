React = require 'react'

module.exports = React.createClass

  contextTypes:
    router: React.PropTypes.object

  componentWillMount: ->
    localStorage.clear()
    window.location.href = '/authenticate'

  render: ->
    null
