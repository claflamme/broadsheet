mongoose = require 'mongoose'

Schema = mongoose.Schema {
  jti: String
  iat: Number
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: 'User'
}

module.exports = mongoose.model 'Token', Schema
