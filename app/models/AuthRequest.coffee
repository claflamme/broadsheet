mongoose = require 'mongoose'

Schema = mongoose.Schema {
  nonce:
    type: String
    unique: true
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: 'User'
}, timestamps: true

module.exports = mongoose.model 'AuthRequest', Schema
