User = App.Models.User

module.exports = class TokenService

  models: [ 'User' ]

  create: (email, password, callback) ->

    user = new User email: email

    user.fetch().then (user) ->

      unless user
        return callback 404, error: message: 'User not found.'

      unless user.passwordIsValid password
        return callback 401, error: message: 'Incorrect password.'

      callback 200, user

    .catch (err) ->

      callback 500, error: message: 'There was an unknown error.'
