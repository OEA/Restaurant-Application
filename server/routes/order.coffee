ctrl = module.exports
Order = require '../models/Order'
ObjectID = require('mongodb').ObjectID

ctrl.init = (app, db) ->
  app.post('/node/order/add', (req, resp) ->
    user = req.body.user
    food = req.body.food
    quantity = req.body.quantity
    price = req.body.price
    if user? and food? and quantity? and price?
      db.collection "orders", (err, collection) =>
        order = new Order(user, food, quantity, price, 3)
        collection.insert order, (err, order) =>
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
              order: order
            )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )

  app.get('/node/order/get/:user', (req, resp) ->
    user = req.params.user
    db.collection "orders", (err, collection) =>
      collection.find({'user':user, 'active':1}).count((err, count) ->
        if count > 0
          collection.find({'user':user,'active':1}).toArray((err, orders) ->
            resp.send(
              code: 200,
              message: "success",
              orders: orders
            )
          )
        else
          resp.send(
            code: 400,
            message: "fail",
            detail: "there is no active order for user which you give."
          )
      )

  )

  app.post('/node/order/changestatus', (req, resp) ->
    id = req.body._id
    status = req.body.status
    _id = new ObjectID(id)
    if id? and status?
      db.collection "orders", (err, orderCollection) =>
        orderCollection.find({'_id':_id}).count((err, orderCount) ->
          if orderCount > 0
            orderCollection.update({'_id':_id},{$set:{'active':status}})
            resp.send(
              code: 200,
              message: "success",
              detail: "Changed succesfully."
            )
          else
            resp.send(
              code: 400,
              message: "fail",
              detail: "There is no active order which you give"
            )
        )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )