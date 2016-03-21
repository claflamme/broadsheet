request = require 'request'
validator = require 'validator'

module.exports =

  ###
  @apiGroup Proxy
  @api { get } /api/proxy Fetch
  @apiParam { String } url A valid URL with an http or https protocol.
  @apiDescription
    A simple proxy for fetching images and pages from the same domain.
  ###
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

    request.get(url).pipe res
