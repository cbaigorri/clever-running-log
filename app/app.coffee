###
Module dependencies
###

express = require 'express'
less = require 'less'
passport = require 'passport'
BrowserIDStrategy = require('passport-browserid').Strategy
routes = require './routes'

app = module.exports = express.createServer()


###
Passport
###

passport.serializeUser (user, done) ->
  done null, user.email

passport.deserializeUser (email, done) ->
  done null, {email: email}

passport.use new BrowserIDStrategy { audience: 'http://localhost:3000' }, (email, done) ->
  # database interface goes here
  done null, {email: email}


###
Configuration
###

app.configure( ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.compiler(
    src: __dirname + '/public', 
    enable: ['less', 'coffeescript'] 
  )
  app.use app.router
  app.use express.static(__dirname + '/public')
)

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
  app.use express.errorHandler()


###
Routes
###

app.get '/', routes.index

app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

