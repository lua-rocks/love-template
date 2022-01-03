-- luacheck: no unused

---# `PRÖTØ`
---## The simplest implementation of a prototype ÖØP in Lua
---**Memoire:** when using variadic arguments in any functions from this
---library, their order is always matters!
---The variables on the left have a higher priority.
---@class lib.proto
local proto = {}

---## Multiple inheritance (fast)
---Links a table via `__index` with all tables passed in arguments.
---Optionally you can give it a name in `__tostring`
---by passing **string** at the end.
---
---Calling `proto()` with more than one argument will redirect to this function.
---@generic T
---@param t T a table that will link to all the other tables
---@vararg table set of any tables
---@return T result
function proto.link(t, ...) end

---## Metadata merging
---Modifies the metatable of the passed table, combining all metaslots in it:
---its own and inherited from linked via `__index`.
---*Doesn't return anything!*
---@param t table
function proto.merge_meta(t) end

---## Extracting relatives
---Gets all tables adhered to this table through `__index`
---in order, starting with itself. Supports combined indexes
---(index functions that return an array with indexes
---when called without arguments).
---@param t table
---@param limit? integer don't search deeper
---@return table[] tables
function proto.get_tables(t, limit) end

---## Slot looping
---Iterator to enumerate tables with `__index` metaslots
---
---Calling `proto()` with a single argument will redirect to this function.
---```lua
---for k, v, t in proto(x) do
---  print(tostring(x) ..
---    ' has slot ' .. tostring(k) ..
---    ' from table ' .. tostring(t) ..
---    ' and its value is ' .. tostring(v))
---end
---```
function proto.iter(t) end

return proto
