request = require 'request'
validator = require 'validator'
read = require 'node-readability'

module.exports = (app) ->

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

    request url, (err, httpRes, body) ->
      res.json status: httpRes.statusCode, body: body

  getArticle: (req, res) ->

    read req.query.url, (err, article, httpRes) ->
      body = article?.content or 'There was an error fetching this article.'
      res.json { body }
      article.close()