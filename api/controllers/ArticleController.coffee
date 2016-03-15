Article = App.Models.Article

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
