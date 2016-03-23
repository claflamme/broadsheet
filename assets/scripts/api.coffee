module.exports =

  send: (options, cb) ->

    cb or= ->
      undefined
      
    options.headers or= {}

    options.headers['content-type'] = 'application/json'

    if token = localStorage.getItem 'token'
      options.headers['Authorization'] = "Bearer #{ token }"

    if options.body
      options.body = JSON.stringify options.body

    fetch(options.url, options).then (res) ->
      if res.status is 401
        @_refresh()
      else
        res.json().then (json) ->
          cb res, json

  _refresh: ->

    localStorage.clear()
    window.location.reload()
