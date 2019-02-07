Cookies = require 'js-cookie'

refresh = ->
  Cookies.remove'token'
  window.location.reload()

stringifyQueryObject = (queryObject) ->

  queryParams = []

  for k, v of queryObject
    queryParams.push "#{ k }=#{ v }"

  "?#{ queryParams.join '&' }"

module.exports =

  send: (options, cb = ->) ->

    defaults = method: 'get', query: {}, url: ''
    config = Object.assign {}, defaults, options

    config.url += stringifyQueryObject config.query

    req = new XMLHttpRequest()
    req.open config.method, config.url, true
    req.setRequestHeader 'content-type', 'application/json'

    if token = Cookies.get 'token'
      req.setRequestHeader 'Authorization', "Bearer #{ token }"

    req.onreadystatechange = ->
      if req.status is 401
        return refresh()
      if req.readyState isnt 4
        return
      cb req.response, JSON.parse req.responseText

    req.send JSON.stringify config.body

    return req
