local app = require("src.app")
local lovebird = require("lib.debug.lovebird")

function love.load()
  app:init()
  if devmode then
    _L = app
    for _, host in ipairs(lovebird.whitelist) do
      log.info(("Lovebird available at %s:%s"):format(host, lovebird.port))
    end
  end
end

function love.update()
  if devmode then
    lovebird.update()
  end
end

function love.draw()
  app.win:draw_all()
end

function love.resize(w, h)
  app.win:resize(w, h)
end

love.keypressed = function(key)
  app.win:keypressed(key)
end
