constants = require '../constants'

module.exports =

  setFormList: (forms) ->

    action =
      type: constants.FORM_LIST_RECEIVED
      formList: forms

  createForm: (form) ->

    action =
      type: constants.FORM_CREATED
      form: form
