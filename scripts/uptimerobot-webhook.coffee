url = require('url')
querystring = require('querystring')

module.exports = (robot) ->
  robot.router.post "/uptimerobot", (req, res) ->

    query = querystring.parse(url.parse(req.url).query)

    user = {}
    user.room = query.room if query.room
#    user.type = query.type if query.type

#    {room} = req.params;
#    {monitorID, monitorURL, monitorFriendlyName, alertType, alertDetails, monitorAlertContacts} = url.parse(req.url, true).query

    status = switch query.alertType
        when '0' then 'paused'
        when '1' then 'not checked yet'
        when '2' then 'up'
        when '8' then 'seems down'
        when '9' then 'down'

    try
      robot.send user, "Monitor is #{status} #{query.monitorFriendlyName} (#{query.monitorURL})"
    catch error
      console.log "uptimerobot error: #{error}."

    res.end "OK"
