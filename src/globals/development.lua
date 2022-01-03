inspect = require("lib.inspect")
execute = require("lib.execute")

---Print inspection of the variable.
---@param ... any
function dump(...)
  print(inspect(...))
end
