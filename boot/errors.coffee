errors = require '../api/errors'

module.exports = (req, res, next) ->

  res.error = (errorKey, details) ->

    statusCode = errors[errorKey].status
    data =
      error:
        type: errorKey
        message: errors[errorKey].message

    if details
      data.error.details = details

    res.status(statusCode).json data

  next()
