{ createStore, applyMiddleware, compose } = require 'redux'
thunk = require 'redux-thunk'
rootReducer = require  '../reducers'

finalCreateStore = compose(applyMiddleware(thunk)) createStore

module.exports = (initialState) ->
  return finalCreateStore rootReducer, initialState
