User = App.Models.User

module.exports = (req, email, password, done) ->

  User.findOne {'email': email}, (err, user) ->
    if err
      done err
    else if not user
      done null, false, req.flash('loginMessage', 'No user found.')
    else if not user.passwordIsValid(password)
      done null, false, req.flash('loginError', 'Wrong password.')
    else
      # Success
      done null, user
