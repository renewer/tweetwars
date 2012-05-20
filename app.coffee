ApiServer = require 'apiserver'
config = require 'config'

apiserver = new ApiServer()
port = process.env.PORT || config.port
apiserver.listen port, onListen
console.log "API server listening on port #{port} in #{process.env.NODE_ENV} mode"

onListen = (err) ->
  if err
    console.error "Something terrible happened: #{err.message}"
  else
    console.log "Successfully bound to port #{@port}"
    setTimeout apiserver.close onClose, 5000

onClose = () -> console.log "port unbound correctly"

twitter = require 'ntwitter'
twit = new twitter config.twitter

getbb = (lat, lon) ->
  "#{lon-0.1},#{lat-0.1},#{lon+0.1},#{lat+0.1}"

filter =
  'locations': getbb config.location.lat, config.location.lon

console.log filter

tweets = []

twit.stream 'statuses/filter', filter, (stream) ->
  stream.on 'data', (data) ->
        console.log data.coordinates, data.created_at, data.text
        tweets.push data
