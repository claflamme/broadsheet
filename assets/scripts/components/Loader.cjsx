React = require 'react'

Loader = (props, context) ->

  unless props.show
    return null

  <div className='loader'>
    <div className='bounce1'></div>
    <div className='bounce2'></div>
    <div className='bounce3'></div>
  </div>

Loader.propTypes =

  show: React.PropTypes.bool

module.exports = Loader
