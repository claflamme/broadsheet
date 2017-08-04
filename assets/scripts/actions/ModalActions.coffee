constants = require '../constants'

module.exports =
  setVisibility: (visibility) ->
    type: constants.MODAL_VISIBILITY_UPDATED
    visibility: visibility
