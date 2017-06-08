React = require 'react'
el = React.createElement
pt = require 'prop-types'

Loader = (props, context) ->
  unless props.show
    return null

  el 'div', className: 'loader',
    el 'div', className: 'loader-ball bounce1'
    el 'div', className: 'loader-ball bounce2'
    el 'div', className: 'loader-ball bounce3'

Loader.propTypes =
  show: pt.bool

Loader.defaultProps =
  show: false

module.exports = Loader
