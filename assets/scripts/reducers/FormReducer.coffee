module.exports =

  initialState:
    formList: []
    activeForm: {}

  FORM_LIST_RECEIVED: (state, action) ->

    state.formList = action.formList or []

    return state

  FORM_CREATED: (state, action) ->

    state.formList.push action.form

    return state
