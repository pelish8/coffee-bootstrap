config = require './config'

express = require 'express'
engines = require 'consolidate'
app = express()

app.engine 'haml', engines.haml
#tempalte
app.engine 'html', engines.hogan
app.set 'views', __dirname + config.TEMPLATE_PATH


app.use '/js',
  express.static __dirname + '/../js'

app.use '/css',
  express.static __dirname + '/../css'

app.get '/',
  (req, res) ->
    res.render 'index.haml'

app.listen 3000

console.log 'App started on http://localhost:3000'
