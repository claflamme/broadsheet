constants = require '../constants'

module.exports =

  showSubscriptionEdit: ->

    type: 'MODAL_EDIT_SUBSCRIPTION_TOGGLED', show: true

  hideSubscriptionEdit: ->

    type: 'MODAL_EDIT_SUBSCRIPTION_TOGGLED', show: false

  editSubscription: (subscription) ->

    type: 'SUBSCRIPTION_EDITED', subscription: subscription
