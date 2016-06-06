React = require 'react'

module.exports = React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    localStorage.clear()
    window.location.href = '/login'

  render: ->

    null
