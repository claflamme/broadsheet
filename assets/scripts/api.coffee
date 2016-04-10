refresh = ->

  localStorage.clear()
  window.location.reload()

module.exports =

  send: (options, cb) ->

    cb or= -> undefined

    options.headers or= {}

    options.headers['content-type'] = 'application/json'

    if token = localStorage.getItem 'token'
      options.headers['Authorization'] = "Bearer #{ token }"

    if options.body
      options.body = JSON.stringify options.body

    if options.query
      queryParams = []
      for k, v of options.query
        queryParams.push "#{ k }=#{ v }"
      options.url += "?#{ queryParams.join '&' }"

    fetch(options.url, options).then (res) ->
      if res.status is 401
        refresh()
      else
        res.json().then (json) ->
          cb res, json
