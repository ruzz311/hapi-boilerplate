Hapi    = require 'hapi'
path    = require 'path'
app     = 
    config: require './config'
    routes: require './routes'

server  = Hapi.createServer 'localhost', 8000, app.config

#
# Attach Routes
# 

for i in [0...app.routes.length]
    server.route app.routes[i]

console.log server

#
# Logging
#


# Generic Error Logging
server.on 'log', (event, tags)->
    console.log("Server error: #{event.data}") if tags.error  

# Internal Error Logging
server.on 'internalError', (req, err)-> 
    console.log("Error response (500) for request #{req.id}: #{err.message}", err)

# Cooke Error Logging
server.on 'request', (req, event, tags)->
   if (tags.error && tags.state)
       console.error "Cookie parsing error in request #{req.id}!"

###
# Log everything
evntHandle = (evnt, args)-> 
    console.log evnt, '\n', args
    
for evnt in [ 'log', 'request', 'response', 'tail', 'internalError' ]
    server.on evnt, ()-> 
        evntHandle( evnt, arguments)
###

#
# Start the server
# 

server.start ()-> 
    console.log JSON.stringify
        "action"    : "server.start"
        "host"      : "#{server.settings.host}"
        "port"      : "#{server.settings.port}"
        "timestamp" : (new Date()).getTime()
