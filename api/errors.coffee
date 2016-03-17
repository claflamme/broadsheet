module.exports =

  # --- Authentication ---------------------------------------------------------

  AUTH_MISSING_FIELD:
    message: 'Both email and password are required.'
    status: 400

  AUTH_INVALID_EMAIL:
    message: 'The provided email is invalid.'
    status: 400

  AUTH_EMAIL_EXISTS:
    message: 'Email already exists.'
    status: 400

  AUTH_PASSWORD_TOO_LONG:
    message: 'Password is too long.'
    status: 400

  AUTH_USER_NOT_FOUND:
    message: 'User not found.'
    status: 404

  AUTH_PASSWORD_INCORRECT:
    message: 'Incorrect password.'
    status: 400

  AUTH_UNKNOWN:
    message: 'Unknown authentication error.'
    status: 500

  # --- Feeds ------------------------------------------------------------------

  FEED_UNKNOWN_ERROR:
    message: 'There was an unknown error querying feeds.'
    status: 500

  # --- Subscriptions ----------------------------------------------------------

  SUBSCRIPTION_URL_REQUIRED:
    message: 'The url field is required.'
    status: 400

  SUBSCRIPTION_URL_INVALID:
    message: 'The provided url is invalid.'
    status: 400

  SUBSCRIPTION_NOT_FOUND:
    message: 'No subscription was found for the provided feed ID(s).'
    status: 404

  SUBSCRIPTION_UNKNOWN_ERROR:
    message: 'There was an unknown error while querying subscriptions.'
    status: 500

  # --- Proxy ------------------------------------------------------------------

  PROXY_URL_REQUIRED:
    message: 'The url parameter is required in the query string.'
    status: 400

  PROXY_INVALID_URL:
    message: 'The url param must be a valid URL with an http or https protocol.'
    status: 400

  # --- Article ----------------------------------------------------------------

  ARTICLE_UNKNOWN_ERROR:
    message: 'There was an unknown error querying articles.'
    status: 500

  ARTICLE_NOT_FOUND:
    message: 'The requested article was not found.'
    status: 404
