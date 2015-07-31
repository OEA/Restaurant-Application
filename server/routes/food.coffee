ctrl = module.exports
Food = require '../models/Food'

ctrl.init = (app, db) ->
  app.get('/food', (req, resp) ->
    resp.send(
      code: 200
      message: "success"
    )
  )
