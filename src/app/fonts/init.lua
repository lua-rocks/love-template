---@class src.app.fonts
---@field current love.Font
---@field normal love.Font
---@field bold love.Font
local fonts = proto.set_name({}, "src.app.fonts")

---@generic S
---@param self S|src.app.fonts
---@return S|src.app.fonts self
function fonts:init()
  local names = { "normal", "bold" }
  for _, name in ipairs(names) do
    self[name] = love.graphics.newImageFont(
      "res/img/fonts/" .. name .. ".png",
      " 0123456789,.-=;:@#$^&?!+()%\"/*"
        .. "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        .. "abcdefghijklmnopqrstuvwxyz"
        .. "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
        .. "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
        .. "<>'_[]{}",
      1
    )
  end
  self:switch("bold")
  return self
end

---@param name string
function fonts:switch(name)
  self.current = self[name]
  love.graphics.setFont(self.current)
  return self
end

return fonts
