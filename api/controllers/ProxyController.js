const request = require('request');
const validator = require('validator');

module.exports = {

  /**
   * @apiGroup Proxy
   * @api { get } /api/proxy Fetch
   * @apiParam { String } url A valid URL with an http or https protocol.
   * @apiDescription
   *  A simple proxy for fetching images and pages from the same domain.
   */
  get: function (req, res) {

    const url = req.query.url;
    const validatorConfig = {
      require_protocol: true,
      require_valid_prototcol: true,
      protocols: ['http', 'https']
    };

    if (!url) {
      return res.error('MISSING_QUERY_PARAMS', 'url');
    }

    if (!validator.isURL(url, validatorConfig)) {
      return res.error('PROXY_INVALID_URL');
    }

    request.get(url).pipe(res);

  }

};
