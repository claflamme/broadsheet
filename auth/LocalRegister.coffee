User = App.Models.User

module.exports = (email, password, done) ->

  new User(email: email).fetch()
  .then (user) ->
    if user
      # email already taken
      done null, false
    else
      user = new User email: email, password: password
      user.save()
      .then (user) ->
        done null, user
      .catch (err) ->
        console.log err
        done err
  .catch (err) ->
    console.log err
    done err
