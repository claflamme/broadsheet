bcrypt = require 'bcryptjs'

module.exports = (app) ->

  # --- Helpers ----------------------------------------------------------------

  transformer = (doc, ret, opts) ->

    delete ret.password
    return ret

  hashPassword = (password) ->

    salt = bcrypt.genSaltSync app.config.auth.bcryptSaltRounds
    bcrypt.hashSync password, salt

  # -- Schema ------------------------------------------------------------------

  schema =

    email:
      type: String
      unique: true

    password:
      type: String
      set: hashPassword

  Schema = app.mongoose.Schema schema, timestamps: true

  # --- Options ----------------------------------------------------------------

  Schema.set 'toJSON', transform: transformer
  Schema.set 'toObject', transform: transformer

  # --- Document and Model Methods ---------------------------------------------

  Schema.methods =

    passwordMatches: (providedPassword) ->

      bcrypt.compareSync providedPassword, @password

  Schema.statics =

    passwordIsCorrectLength: (providedPassword) ->

      # 72 bytes is the max length of a password allowed by bcrypt.
      byteLength = Buffer.byteLength providedPassword, 'utf8'
      byteLength <= 72

  return Schema
