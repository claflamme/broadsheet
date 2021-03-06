request = require 'request'
validator = require 'validator'

module.exports = (app) ->

  # A simple proxy for fetching images and pages from the same domain.
  get: (req, res) ->

    url = req.query.url
    validatorConfig =
      require_protocol: true
      require_valid_prototcol: true
      protocols: ['http', 'https']

    unless url
      return res.error 'MISSING_QUERY_PARAMS', 'url'

    unless validator.isURL url, validatorConfig
      return res.error 'PROXY_INVALID_URL'

    request(url)
    .on 'error', (err) ->
      return res.error 'PROXY_STREAM_ERROR'
    .pipe res
