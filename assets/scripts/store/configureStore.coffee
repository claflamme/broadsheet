{ createStore, applyMiddleware, compose } = require 'redux'
rootReducer = require  '../reducers'

finalCreateStore = compose() createStore

module.exports = (initialState) ->
  return finalCreateStore rootReducer, initialState
