module.exports =

  AUTH_MISSING_FIELD:
    message: 'Both email and password are required.'
    status: 400

  AUTH_INVALID_EMAIL:
    message: 'The provided email is invalid.'
    status: 400

  AUTH_EMAIL_EXISTS:
    message: 'Email already exists.'
    status: 400

  AUTH_PASSWORD_TOO_LONG:
    message: 'Password is too long.'
    status: 400

  AUTH_USER_NOT_FOUND:
    message: 'User not found.'
    status: 404

  AUTH_PASSWORD_INCORRECT:
    message: 'Incorrect password.'
    status: 400

  AUTH_UNKNOWN:
    message: 'Unknown authentication error.'
    status: 500
