BOT_ID = "duxca"
KEYS = require("./#{BOT_ID}_key")
AQUESTALKPI = "/home/pi/aquestalkpi/AquesTalkPi"

Twitter = require("twitter")
exec = require('child_process').exec

main = ->
  twit = new Twitter(KEYS)
  twit.stream "user", (stream)->
    stream.on "data", ({id_str, user, text})->
      if text? then talk(text)

talking = false
talk = (text, cb)->
  if talking then return cb(false)
  talking = true
  exec "#{AQUESTALKPI} \"#{text}\" | aplay", (err, stdout, stderr)->
    talking = false
    if !err then cb()
    else
      console.log err
      console.log err.code
      console.log err.signal

main()