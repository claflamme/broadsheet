exports.up = (knex) ->

  knex.schema.createTable 'users', (table) ->
    table.increments()
    table.timestamps()
    table.text('email').unique()
    table.text 'password'

  .createTable 'feeds', (table) ->
    table.increments()
    table.timestamps()
    table.text('url').notNullable()

  .createTable 'feeds_users', (table) ->
    table.integer('feed_id').references 'feeds.id'
    table.integer('user_id').references 'users.id'
    table.text 'custom_name'

  .createTable 'articles', (table) ->
    table.increments()
    table.timestamps()
    table.integer('feed_id').references('feeds.id').notNullable()
    table.text('title').unique().notNullable()
    table.text 'description'
    table.text('url').notNullable()

exports.down = (knex) ->

  knex.schema.dropTable 'users'
  knex.schema.dropTable 'feeds'
  knex.schema.dropTable 'feeds_users'
  knex.schema.dropTable 'articles'
