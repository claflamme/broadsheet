React = require 'react'
{ render } = require 'react-dom'
{ Provider } = require 'react-redux'
{ createStore, applyMiddleware, combineReducers } = require 'redux'
thunk = require('redux-thunk').default
reducers = require  './reducers'
Router = require './Router'

# Add redux middleware here. They'll be invoked in the order they're listed.
middleware = [
  thunk
]

# Modules in the `./reducers` folder must export a plain object containing a
# property called "initialState". This method converts a module to a reducer
# function. When an action is dispatched, the function will attempt to invoke
# any methods with the same name as the action type.
createReducer = (reducer) ->
  (state = reducer.initialState, action) ->
    if reducer[action.type]
      state = reducer[action.type] state, action
    state

configureStore = (initialState) ->
  finalCreateStore = applyMiddleware.apply(null, middleware) createStore
  finalCreateStore combineReducers(reducers), initialState

for name, reducer of reducers
  reducers[name] = createReducer reducer

App =
  <Provider store={ configureStore() }>
    <Router />
  </Provider>

if root = document.getElementById 'root'
  render App, root
