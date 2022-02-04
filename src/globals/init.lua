proto = require("lib.table.proto")

log = require("lib.debug.log")
log.usecolor = true
-- log.outfile = "log/main.log"

love.graphics.setDefaultFilter("nearest", "nearest", 0)
love.keyboard.setKeyRepeat(true)

local tick = require("git.tick")
tick.framerate = 100
