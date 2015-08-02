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

  app.post('/category/edit', (req, resp) ->
    name = req.body.name
    update = req.body.update
    if name? and update?
      db.collection "categories", (err, catCollection) =>
        catCollection.find({'name':name}).count((err, catCount) ->
          if catCount > 0
            db.collection "foods", (err, foodCollection) =>
              foodCollection.find({'category':name}).count((err, foodCount) ->
                if foodCount > 0
                  foodCollection.update({'category':name},{$set:{'category':update}})
                else
                  #doNothing
              )

              db.collection "categories", (err, collection) =>
                collection.update({'name':name},{$set:{'name':update}})
                resp.send(
                  code: 200,
                  message: "success"
                )
          else
            resp.send(
              code: 400,
              message: "fail",
              detail: "There is no active category which you give"
            )
        )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )

  app.get('/category/delete/:name', (req, resp) ->
    name = req.params.name
    db.collection "categories", (err, collection) =>
      collection.find({'name':name, 'active':1}).count((err, count) ->
        if count > 0
          collection.findOneAndDelete({'name':name, 'active':1},(err, item) ->
            resp.send(
              code: 200,
              message: "success",
              detail: "Category is deleted from our server."
            )
          )
        else
          resp.send(
            code: 400,
            message: "fail",
            detail: "There is no active category which you give."
          )
      )
  )