config = require '../config'
knex = require('knex') config.db
Bookshelf = require 'bookshelf'

bookshelf = Bookshelf knex
bookshelf.plugin 'visibility'
bookshelf.plugin 'registry'

module.exports = bookshelf
