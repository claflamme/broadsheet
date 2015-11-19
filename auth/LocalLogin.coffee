User = App.Models.User

module.exports = (email, password, done) ->

  new User(email: email).fetch()
  .then (user) ->
    if not user
      done null, false
    else if user.passwordIsValid password
      done null, user
    else
      # wrong password
      done null, false
  .catch (err) ->
    console.log err
    done err
