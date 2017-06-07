React = require 'react'
{ Component } = React
el = React.createElement

class PageNotFound extends Component

  render: ->
    el 'p', {},
      'Page not found.'

module.exports = PageNotFound
