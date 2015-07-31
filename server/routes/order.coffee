ctrl = module.exports
Order = require '../models/Order'

ctrl.init = (app, db) ->
  app.get('/order', (req, resp) ->
    resp.send(
      code: 200
      message: "success"
    )
  )