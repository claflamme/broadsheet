User = App.Models.User

module.exports = (req, email, password, done) ->

  User.findOne {'email': email}, (err, user) ->
    if err
      done err
    else if user
      done null, false, req.flash('signupMessage', 'Email taken.')
    else
      user = new User()
      user.email = email
      user.password = password
      user.save (err) ->
        done err, user
