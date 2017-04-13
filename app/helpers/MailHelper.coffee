path = require 'path'

mailgun = require 'mailgun-js'
pug = require 'pug'

module.exports = (app) ->

  send: (templatePath, data = {}, cb) ->

    paths = app.config.paths
    templatePath = path.join paths.root, paths.views, "#{ templatePath }.pug"
    data.html = pug.renderFile templatePath, data

    mailer = mailgun
      apiKey: app.config.mail.mailgun.secretKey
      domain: app.config.mail.mailgun.domain

    mailer.messages().send data, cb
