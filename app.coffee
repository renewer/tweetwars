ApiServer = require 'apiserver'

config =
  port: 3000

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

