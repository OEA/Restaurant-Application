ctrl = module.exports
User = require '../models/User'

ctrl.init = (app, db) ->
  app.get('/user', (req, resp) ->
    resp.send(
      code: 200
      message: "success"
    )
  )