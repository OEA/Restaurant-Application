ctrl = module.exports
Category = require '../models/Category'

ctrl.init = (app, db) ->
  app.post('/category/add', (req, resp) ->
    name = req.body.name
    if name?
      db.collection "categories", (err, collection) =>
        collection.find({'name':name}).count((err, count) ->
          if count > 0
            resp.send(
              code: 400,
              message: "fail",
              detail: "Category was already added."
            )
          else
            category = new Category(name, 1)
            collection.insert category, (err, category) =>
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
                  category: category
                )
        )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )

  app.get('/category/list', (req, resp) ->
    db.collection "categories", (err, collection) =>
      collection.find({'active':1}).count((err, count) ->
        if count > 0
          collection.find({'active':1}).toArray((err, categories) ->
            resp.send(
              code: 200,
              message: "success",
              categories: categories
            )
          )
        else
          resp.send(
            code: 400,
            message: "fail",
            detail: "there is no active category."
          )
      )

  )