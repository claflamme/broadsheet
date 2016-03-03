{ combineReducers } = require 'redux'

reducers =
  auth: require './AuthReducer'

baseReducer = (reducer) ->

  (state = reducer.initialState, action) ->

    if reducer[action.type]
      state = reducer[action.type] state, action

    return state

for name, reducer of reducers
  reducers[name] = baseReducer reducer

module.exports = combineReducers reducers
