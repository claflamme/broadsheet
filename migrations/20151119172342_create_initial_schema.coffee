exports.up = (knex) ->

  knex.schema

  .createTable 'users', (table) ->
    table.increments()
    table.text('email').unique()
    table.text 'password'
    table.timestamps()

  .createTable 'tokens', (table) ->
    table.increments()
    table.integer('user_id').references 'users.id'
    table.text 'jti'
    table.timestamps()

  .createTable 'feeds', (table) ->
    table.increments()
    table.text 'title'
    table.text 'description'
    table.text('url').notNullable()
    table.timestamps()

  .createTable 'subscriptions', (table) ->
    table.integer('feed_id').references 'feeds.id'
    table.integer('user_id').references 'users.id'
    table.text 'custom_name'

  .createTable 'articles', (table) ->
    table.increments()
    table.integer('feed_id').references('feeds.id').notNullable()
    table.text('title').unique().notNullable()
    table.text 'summary'
    table.text 'description'
    table.text('url').notNullable()
    table.timestamps()

exports.down = (knex) ->

  knex.schema

  .table 'tokens', (table) ->
    table.dropForeign 'users', 'tokens_user_id_foreign'

  .table 'articles', (table) ->
    table.dropForeign 'feeds', 'articles_feed_id_foreign'

  .table 'subscriptions', (table) ->
    table.dropForeign 'feeds', 'subscriptions_feed_id_foreign'
    table.dropForeign 'users', 'subscriptions_user_id_foreign'

  .dropTable 'articles'
  .dropTable 'subscriptions'
  .dropTable 'tokens'
  .dropTable 'users'
  .dropTable 'feeds'
