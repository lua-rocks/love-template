local lovebird = require("lib.debug.lovebird")
local win

function love.load()
  local app = require("src.app")
  app:init()
  win = app.win
  if devmode then
    _L = app
    for _, host in ipairs(lovebird.whitelist) do
      log.info(
        ("Lovebird is available at \27[4m%s:%s\27[0m."):format(
          host,
          lovebird.port
        )
      )
    end
  end
end

function love.update()
  if devmode then
    lovebird.update()
  end
end

function love.draw()
  win:draw_recursive()
end

function love.resize(w, h)
  win:resize(w, h)
end

function love.keypressed(key)
  win:keypressed(key)
end

function love.mousemoved(x, y)
  win:mousemoved(x, y)
end

function love.mousepressed(x, y, button)
  win:mousepressed(x, y, button)
end
