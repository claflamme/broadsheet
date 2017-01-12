React = require 'react'

Loader = (props, context) ->

  unless props.show
    return null

  <div className='loader'>
    <div className='loader-ball bounce1'></div>
    <div className='loader-ball bounce2'></div>
    <div className='loader-ball bounce3'></div>
  </div>

Loader.propTypes =
  show: React.PropTypes.bool

Loader.defaultProps =
  show: false

module.exports = Loader
