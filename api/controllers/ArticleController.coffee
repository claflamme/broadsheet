Article = App.Models.Article
User = App.Models.User

module.exports =

  ###
  @apiGroup Articles
  @api { get } /api/articles/:id Details
  @apiParam { String } id The ID of the desired article.
  @apiDescription Gets the details of a single article.
  ###
  show: (req, res) ->

    article = new Article id: req.params.id

    article.fetch().then (article) ->

      unless article
        return res.error 'ARTICLE_NOT_FOUND'

      res.json article

    .catch (err) ->

      console.error err
      res.error 'ARTICLE_UNKNOWN_ERROR'

  ###
  @apiGroup Articles
  @api { get } /api/articles Search/List
  @apiParam { String } [q=''] Search query string.
  @apiParam { Number } [limit=20] Max number of results to return.
  @apiParam { Number } [offset=0] Number of results to start returning from.
  @apiDescription
    Lists all articles from all subscriptions that a user has. Can optionally
    be searched using the `q` query param.
  ###
  search: (req, res) ->

    q = req.query.q
    article = Article.forge()
    user = User.forge id: req.user.sub

    user.subscriptions().fetch().then (subscriptions) ->

      subscriptionIds = subscriptions.serialize().map (subscription) ->
        subscription.id

      article = article.query (query) ->
        query.whereIn 'feed_id', subscriptionIds
        .andWhere 'title', 'ILIKE', "%#{ q or '' }%"
        .offset req.query.offset or 0
        .limit req.query.limit or 20
        .orderBy 'published_at', 'desc'

      article.fetchAll().then (articles) ->
        res.json articles
