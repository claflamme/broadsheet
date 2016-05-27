React = require 'react'

module.exports = React.createClass

  contextTypes:

    router: React.PropTypes.object

  componentWillMount: ->

    localStorage.clear()
    @context.router.push '/'

  render: ->

    null
