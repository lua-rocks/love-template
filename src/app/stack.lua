---Stack of drawables. Used to implement methods `on_click`, `on_hower` etc.
---Only elements with these methods should be added on stack.
---@class src.app.stack

---@type src.app.stack|src.proto.drawable[]
local stack = proto.set_name({}, "src.app.stack")

---@param drawable src.proto.drawable
---@return integer index
function stack:push(drawable)
  local last = #self + 1
  self[last] = drawable
  return last
end

---@param element src.proto.drawable|integer
---@return integer|src.proto.drawable index or `nil` if failed.
function stack:pop(element)
  if type(element) == "number" then
    self[element] = nil
    return element
  else
    for index, value in ipairs(self) do
      if value == element then
        self[index] = nil
        return index
      end
    end
  end
  return nil
end

---@param point { [1]:integer, [2]:integer }
---@return src.proto.drawable? element
---@return integer? index
function stack:touch(point)
  for index, element in ipairs(self) do
    for i = 1, 2 do
      local pos = element.abs_pos[i]
      local size = element.abs_size[i]
      if point[i] < pos or point[i] > pos + size then
        break
      elseif i == 2 then
        return element, index
      end
    end
  end
end

return stack
