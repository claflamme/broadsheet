const bcrypt = require('bcryptjs');

/* globals App */

// --- Helpers ------------------------------------------------------------------

function transformer (doc, ret) {

  const plainObject = ret;

  delete plainObject.password;
  return plainObject;

}

function hashPassword (password) {

  const salt = bcrypt.genSaltSync(App.Config.auth.bcryptSaltRounds);
  return bcrypt.hashSync(password, salt);

}

// --- Schema ------------------------------------------------------------------

const schema = {

  email: {
    type: String,
    unique: true
  },

  password: {
    type: String,
    set: hashPassword
  }

};

const Schema = App.Mongoose.Schema(schema, { timestamps: true });

// --- Options -----------------------------------------------------------------

Schema.set('toJSON', { transform: transformer });
Schema.set('toObject', { transform: transformer });

// --- Methods ----------------------------------------------

Schema.methods.passwordMatches = function (providedPassword) {
  return bcrypt.compareSync(providedPassword, this.password);
};

// 72 bytes is the max length of a password allowed by bcrypt.
Schema.statics.passwordIsCorrectLength = function (providedPassword) {
  return Buffer.byteLength(providedPassword, 'utf8') <= 72;
};

module.exports = Schema;
