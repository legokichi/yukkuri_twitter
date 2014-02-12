BOT_ID = "duxca"
KEYS = require("./#{BOT_ID}_key")
AQUESTALKPI = "/home/pi/aquestalkpi/AquesTalkPi"

Twitter = require("twitter")
exec = require('child_process').exec

main = ->
  twit = new Twitter(KEYS)
  twit.stream "user", (stream)->
    stream.on "data", ({id_str, user, text})->
      if text? and user.screen_name isnt BOT_ID
        console.log text
        exec '#{AQUESTALKPI} \"#{text}\" | aplay', (err, stdout, stderr)->
          if !err
            console.log "stdout:"+stdout
            console.log "stderr:"+stderr
          else
            console.log err
            console.log err.code
            console.log err.signal

main()