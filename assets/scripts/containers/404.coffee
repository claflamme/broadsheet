React = require 'react'
c = React.createElement

module.exports = React.createClass

  render: ->
    c 'p', {},
      'Page not found.'
