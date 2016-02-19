errors = require '../api/errors'

module.exports = (req, res, next) ->

  res.error = (errorKey) ->

    statusCode = errors[errorKey].status
    data =
      error:
        type: errorKey
        message: errors[errorKey].message

    res.status(statusCode).json data

  next()
