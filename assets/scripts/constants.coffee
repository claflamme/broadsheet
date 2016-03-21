keymirror = require 'keymirror'

module.exports = keymirror

  # --- Authentication ---------------------------------------------------------

  # User has attempted to log in.
  AUTH_TOKEN_REQUESTED: null

  # Server responded with a new auth token.
  AUTH_TOKEN_RECEIVED: null

  # --- Subscriptions ----------------------------------------------------------

  # The user's subscriptions have been requested.
  SUBSCRIPTIONS_REQUESTED: null

  # A list of the user's feed subscriptions has been fetched.
  SUBSCRIPTIONS_RECEIVED: null

  # User has requested that the "New Subscription" prompt be shown.
  SUBSCRIPTIONS_PROMPT_OPENING: null

  # User has closed the "New Subscription" prompt.
  SUBSCRIPTIONS_PROMPT_CLOSING: null

  # Sent a request to add a new subscription.
  SUBSCRIPTIONS_ADDING_NEW: null

  # New subscription added successfully.
  SUBSCRIPTIONS_ADDED_NEW: null
