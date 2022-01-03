function love.load()
  require("src.globals")
  require("globals.development")
  require("run.debugger")
end

function love.update() end

function love.draw()
  local message = "Hello World!"
  love.graphics.print(message, 8, 8)
end
