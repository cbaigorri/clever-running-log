
###
GET home page.
###

exports.index = (req, res) ->
  res.render 'index', { title: 'Clever Running' }