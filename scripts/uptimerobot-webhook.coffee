url = require('url');

module.exports = (robot) ->
  robot.router.get "/uptimerobot/:room", (req, res) ->
    {room} = req.params;
    {monitorID, monitorURL, monitorFriendlyName, alertType, alertDetails, monitorAlertContacts} = url.parse(req.url, true).query

    status = switch alertType
        when '0' then 'paused'
        when '1' then 'not checked yet'
        when '2' then 'up'
        when '8' then 'seems down'
        when '9' then 'down'

    robot.send {room: room}, """
    Monitor is #{status}
    #{monitorFriendlyName} (#{monitorURL})
    """

    res.end "OK"
