mongoose = require 'mongoose'

Schema = mongoose.Schema {
  email:
    type: String
    unique: true
}, timestamps: true

module.exports = mongoose.model 'User', Schema
