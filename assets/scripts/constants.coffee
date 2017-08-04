keymirror = require 'keymirror'

module.exports = keymirror

  # --- Authentication ---------------------------------------------------------

  # User has attempted to log in.
  AUTH_TOKEN_REQUESTED: null

  # Server responded with a new auth token.
  AUTH_TOKEN_RECEIVED: null

  # Auth or registration request was rejected.
  AUTH_TOKEN_FAILED: null

  # Auth token request was completed successfully - an email has been sent.
  AUTH_TOKEN_SUCCESS: null

  # Requested the user model of the token bearer.
  AUTH_USER_REQUESTED: null

  # Got a user model.
  AUTH_USER_RECEIVED: null

  # --- Subscriptions ----------------------------------------------------------

  # The user's subscriptions have been requested.
  SUBSCRIPTIONS_REQUESTED: null

  # The list of feed subscriptions has been updated.
  SUBSCRIPTION_LIST_UPDATED: null

  # A single subscription was updated with new information.
  SUBSCRIPTION_UPDATED: null

  # One or more subscriptions were deleted.
  SUBSCRIPTION_DELETED: null

  # The state of the UI related to subscriptions has been changed.
  SUBSCRIPTION_UI_UPDATED: null

  # --- Articles ---------------------------------------------------------------

  # A request was sent to fetch an article list.
  ARTICLES_REQUESTED: null

  # A list of articles has been fetched from the server. These articles should
  # overwrite the current list.
  ARTICLES_RECEIVED: null

  # Sent a request to the server to fetch some cleaned up article HTML.
  ARTICLE_CONTENT_REQUESTED: null

  # The cleaned up, HTML body content of an article has been fetched from
  # the server.
  ARTICLE_CONTENT_RECEIVED: null

  # The article reader has been closed by the user.
  ARTICLE_CONTENT_HIDDEN: null

  # --- Modal windows ----------------------------------------------------------

  # An attempt to add a new subscription resulted in an error.
  MODAL_NEW_SUBSCRIPTION_RETURNED_ERROR: null

  # A modal window's visibility has been changed.
  MODAL_VISIBILITY_UPDATED: null
