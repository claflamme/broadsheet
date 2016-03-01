{ combineReducers } = require 'redux'

reducers =
  forms: require './FormReducer'

baseReducer = (reducer) ->

  (state, action) ->

    state or= reducer.initialState

    if reducer[action.type]
      state = reducer[action.type] state, action

    return state

for name, reducer of reducers
  reducers[name] = baseReducer reducer

module.exports = combineReducers reducers
