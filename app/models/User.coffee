bcrypt = require 'bcryptjs'

module.exports = (mongoose) ->

  schema = mongoose.Schema
    email: String
    password: String

  schema.pre 'save', (next) ->
    if @isModified 'password'
      hash = bcrypt.hashSync @password, 10
      @set 'password', hash
      next()

  schema.methods.passwordIsValid = (password) ->
    bcrypt.compareSync password, @password

  mongoose.model 'User', schema
