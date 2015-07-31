food = require './food'
order = require './order'
user = require './user'

ctrl = module.exports

ctrl.init = (app, db) ->
  food.init(app, db)
  order.init(app, db)
  user.init(app, db)