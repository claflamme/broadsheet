exports.up = (knex) ->

  knex.schema.createTable 'feeds', (table) ->
    table.increments()
    table.timestamps()
    table.text('url').unique()

exports.down = (knex) ->

  knex.schema.dropTable 'feeds'
