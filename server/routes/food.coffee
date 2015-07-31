ctrl = module.exports
Food = require '../models/Food'
Category = require '../models/Category'

ctrl.init = (app, db) ->
  app.post('/food/add', (req, resp) ->
    name = req.body.name
    category = req.body.category
    image = req.body.image
    price = req.body.price

    if name? and category? and image? and price?
      db.collection "foods", (err, collection) =>
        collection.find({'name':name}).count((err, count) ->
          if count > 0
            resp.send(
              code: 400,
              message: "fail",
              detail: "Food was already added."
            )
          else
            food = new Food(name, category, image, price, 1)
            collection.insert food, (err, food) =>
              if err
                resp.send(
                  code: 400,
                  message: "fail",
                  detail: "db error"
                )
              else
                resp.send(
                  code:200,
                  message: "success",
                  category: food
                )
        )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )
