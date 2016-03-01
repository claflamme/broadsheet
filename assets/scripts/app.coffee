{ render } = require 'react-dom'
Router = require './Router'

if root = document.getElementById 'root'
  render Router, root
