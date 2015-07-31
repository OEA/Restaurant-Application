http = require 'http'
express = require 'express'
bodyParser = require 'body-parser'
mongodb = require("mongodb").MongoClient

app = express()
api = require './routes'
mongodb.connect('mongodb://localhost:27017/restaurant', (err, db) ->
  if err
    console.log "Couldn't connect to Database"
  else
    api.init(app, db)
    console.log "Connected to Database"
)
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({
  extended: true
}))
server = http.createServer(app)
server.listen(process.env.PORT || 8000)
console.log "listening 8000 port"