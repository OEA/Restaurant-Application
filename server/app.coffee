http = require 'http'
express = require 'express'
app = express()
api = require './routes'
api.init(app)
server = http.createServer(app)
server.listen(process.env.PORT || 8000)
console.log "listening 8000 port"