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

  # Sent a request to add a new subscription.
  SUBSCRIPTIONS_ADDING_NEW: null

  # New subscription added successfully.
  SUBSCRIPTIONS_ADDED_NEW: null

  # One or more subscriptions were edited.
  SUBSCRIPTIONS_EDITED: null

  # One or more subscriptions were deleted.
  SUBSCRIPTIONS_DELETED: null

  # --- Articles ---------------------------------------------------------------

  # A list of articles has been fetched from the server. These articles should
  # overwrite the current list.
  ARTICLES_RECEIVED: null

  # Sent a request to the server to fetch some cleaned up article HTML.
  ARTICLE_CONTENT_REQUESTED: null

  # The cleaned up, HTML body content of an article has been fetched from
  # the server.
  ARTICLE_CONTENT_RECEIVED: null

  # --- Modal windows ----------------------------------------------------------

  # The "new subscription" window has been toggled open or closed.
  MODAL_NEW_SUBSCRIPTION_TOGGLED: null

  # The "edit subscription" window has been opened or closed.
  MODAL_EDIT_SUBSCRIPTION_TOGGLED: null

  # The "unsubscribe" window has been opened or closed.
  MODAL_DELETE_SUBSCRIPTION_TOGGLED: null
