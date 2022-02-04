require("src.globals")
inspect = require("lib.debug.inspect")
devmode = true

--- Debugging any variable with `lib.any.log` and `lib.any.inspect`
---
---```lua
---dump({ "Hello", "World!" })
---```
function dump(...)
  log.debug(inspect(...))
end

love.keypressed = function(key)
  if key == "escape" then
    love.event.quit()
  end
end

log.info("Initialized in development mode.")

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
  package.loaded["lldebugger"] = assert(
    loadfile(os.getenv("LOCAL_LUA_DEBUGGER_FILEPATH"))
  )()
  require("lldebugger").start()
end
