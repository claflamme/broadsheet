{ combineReducers } = require 'redux'

reducers =
  forms: require './FormReducer'

baseReducer = (reducer) ->

  (state, action) ->

    newState = state or reducer.initialState

    if reducer[action.type]
      newState = reducer[action.type] newState, action

    return newState

for name, reducer of reducers
  reducers[name] = baseReducer reducer

rootReducer = combineReducers reducers

module.exports = rootReducer
