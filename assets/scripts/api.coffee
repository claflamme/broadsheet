module.exports =

  send: (options, cb) ->

    cb or= ->
    options.headers or= {}

    options.success = (json, status, xhr) ->
      cb null, xhr, json

    options.error = (xhr, status, err) =>
      if xhr.status is 401
        @_refresh()
      else
        cb err, xhr, xhr.responseText

    if token = localStorage.getItem 'token'
      options.headers['Authorization'] = "Bearer #{ token }"

  _refresh: ->

    localStorage.clear()
    window.location.reload()
