ctrl = module.exports

ctrl.init = (app) ->
  app.get('/', (req, resp) ->
    resp.send(
      code: 200
      message: "hello, world!"
    )
  )