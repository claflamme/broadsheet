exports.up = (knex) ->

  knex.schema.createTable 'users', (table) ->
    table.increments()
    table.timestamps()
    table.text('email').unique()
    table.text 'password'

exports.down = (knex) ->

  knex.schema.dropTable 'users'
