module.exports =

  # --- Feeds ------------------------------------------------------------------

  FEED_UNKNOWN_ERROR:
    message: 'There was an unknown error querying feeds.'
    status: 500

  FEED_URL_REQUIRED:
    message: 'The url field is required for new feeds.'
    status: 400

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

  # --- Generic ----------------------------------------------------------------

  UNKNOWN_ERROR:
    message: 'An unknown or unanticipated error has occured.'
    status: 500

  RESOURCE_NOT_FOUND:
    message: 'The requested resource doesn\'t seem to exist.'
    status: 404

  PERMISSION_DENIED:
    message: 'You don\'t have access to the requested resource.'
    status: 403

  MISSING_REQUEST_BODY_PARAMS:
    message: 'One or more parameters were missing from the request body.'
    status: 400

  INVALID_REQUEST_BODY_PARAMS:
    message: 'One or more parameters in the request body were invalid.'
    status: 400

  MISSING_QUERY_PARAMS:
    message: 'One or more parameters were missing from the query string.'
    status: 400
