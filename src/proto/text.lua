local lg = love.graphics
local Drawable = require("src.proto.drawable")

---@class src.proto.text:src.proto.drawable
---@field text string
---@field text_obj? love.Text
---@field wrap? boolean
---@field shadow? boolean
local Text = proto.link({}, Drawable, "src.proto.text")

function Text:init()
  if not self.colors then
    if self.parent.colors then
      self.colors = { self.parent.colors[1] .. "+2" }
    end
  end
  Drawable.init(self)
  self:update("text")
  return self
end

---@alias src.proto.text-updaters
---|'"text"'

local updaters = {
  text = function(self)
    self.text_obj = lg.newText(self.parent.app.fonts.current, self.text)
    self.abs_size = { self.text_obj:getDimensions() }
    self:update("geometry")
    return self
  end,
}

---@param what src.proto.drawable-updaters|src.proto.text-updaters
function Text:update(what)
  if updaters[what] then
    updaters[what](self)
    if self.on_update then
      self.on_update(self, what)
    end
    return self
  end
  return Drawable.update(self, what)
end

function Text:draw()
  Drawable.draw(self)
  local x, y = unpack(self.abs_pos)
  x, y = x + 1, y - 1
  if self.shadow then
    lg.setColor(self.abs_colors[2])
    lg.draw(self.text_obj, x, y + 1)
    lg.setColor(self.abs_colors[1])
  end
  lg.draw(self.text_obj, x, y)
  return self
end

return Text
