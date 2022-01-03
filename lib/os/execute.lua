---Execute command and return result.
---@param command string
---@return string|number result
---
---```lua
---print(execute("echo $USER"))
---```
return function(command)
  local f = io.popen(command)
  local l = f:read("*a")
  f:close()
  return l
end
