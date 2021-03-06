url = require('url')
querystring = require('querystring')

module.exports = (robot) ->
  robot.router.get "/uptimerobot", (req, res) ->

    # FOR QUERYSTRING
    data = querystring.parse(url.parse(req.url).query)

    # FOR JSON
    #data = req.body

    user = {room: data.room}

    status = switch data.alertType
        when '0' then 'paused'
        when '1' then 'not checked yet'
        when '2' then 'up'
        when '8' then 'seems down'
        when '9' then 'down'

    try
      robot.send user, "#{data.monitorFriendlyName} is #{status} (#{data.monitorURL})"
    catch error
      robot.send "uptimerobot error: #{error}."

    res.end "OK"
