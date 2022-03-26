---@class src.app.fonts
---@field current love.Font
---@field normal love.Font
---@field bold love.Font
local fonts = proto.set_name({}, "src.app.fonts")

local glyphs = " _?!@#$%&\"'`*+-=~,.:;\\/|^<>[](){}0123456789"
  .. "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  .. "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя"

function fonts:init()
  local names = { "normal", "bold" }
  for _, name in ipairs(names) do
    self[name] = love.graphics.newImageFont(
      "res/img/fonts/" .. name .. ".png",
      glyphs,
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
end

return fonts
