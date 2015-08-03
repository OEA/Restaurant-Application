ctrl = module.exports
User = require '../models/User'

ctrl.init = (app, db) ->
  app.post('/node/user/register', (req, resp) ->
    name = req.body.name
    email = req.body.email
    password = req.body.password
    isUser = req.body.isUser

    if name? and email? and password?
      db.collection "users", (err, collection) =>
        collection.find({'email':email}).count((err, count) ->
          if count > 0
            resp.send(
              code: 400,
              message: "fail",
              detail: "Email is picked from someone."
            )
          else
            if isUser?
              user = new User(name, email, password, 0, 1)
            else
              user = new User(name, email, password, 1, 1)
            collection.insert user, (err, user) =>
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
                  user: user
                )
        )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )

  app.post('/node/user/login', (req, resp) ->
    email = req.body.email
    password = req.body.password
    if email? and password?
      db.collection "users", (err, collection) =>
        collection.find({'email':email, 'password':password, 'active':1}).count((err, count) ->
          if count > 0
            collection.findOne({'email':email, 'password':password, 'active':1}, (err, user) ->
              resp.send(
                code: 200,
                message: "success",
                user: user
              )
            )
          else
            resp.send(
              code: 400,
              message: "fail",
              detail: "email or password is wrong"
            )
      )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )



  app.get('/node/user/list', (req,resp) ->
    db.collection "users", (err, collection) =>
      collection.find({'active':1}).count((err, count) ->
        if count > 0
          collection.find({'active':1},{'password':0, '_id':0}).toArray((err, users)->
            resp.send(
              code: 200,
              message: "success",
              users: users
            )
          )
        else
          resp.send(
            code: 400,
            message: "fail",
            detail: "there is no active user which you give."
          )
      )
  )

  app.get('/node/user/:email', (req, resp) ->
    email = req.params.email
    if email?
      db.collection "users", (err, collection) =>
        collection.find({'email':email, 'active':1}).count((err, count) ->
          if count > 0
            collection.findOne({'email':email, 'active':1},{'password':0, '_id':0}, (err, user) ->
              resp.send(
                code: 200,
                message: "success",
                user: user
              )
            )
          else
            resp.send(
              code: 400,
              message: "fail",
              detail: "there is no active user which you give."
            )
        )
    else
      resp.send(
        code: 400,
        message: "fail",
        detail: "Please full the fields."
      )
  )