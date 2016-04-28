React = require 'react'
{ render } = require 'react-dom'
{ Provider } = require 'react-redux'
{ createStore, applyMiddleware, combineReducers } = require 'redux'
thunk = require('redux-thunk').default
Router = require './Router'

# --- Redux Middleware ---------------------------------------------------------
# Middleware will be invoked in the order they're listed.
# ------------------------------------------------------------------------------

middleware = [
  thunk
]

# --- Redux Reducers -----------------------------------------------------------
# Reducer modules export a plain object with an `initialState` property and
# methods named after redux actions. The named methods are called when an action
# with that name is dispatched.
# ------------------------------------------------------------------------------

reducers =
  auth: require './reducers/AuthReducer'
  subscriptions: require './reducers/SubscriptionsReducer'
  modals: require './reducers/ModalsReducer'
  articles: require './reducers/ArticlesReducer'
  reader: require './reducers/ReaderReducer'

# ------------------------------------------------------------------------------

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
