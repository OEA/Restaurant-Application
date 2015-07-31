food = require './food'
order = require './order'
user = require './user'
category = require './category'

ctrl = module.exports

ctrl.init = (app, db) ->
  food.init(app, db)
  order.init(app, db)
  user.init(app, db)
  category.init(app, db)