local lg = love.graphics
local Drawable = require("src.proto.drawable")

---@class src.proto.text:src.proto.drawable
---@field text string
---@field text_obj? love.Text
---@field wrap? boolean
local Text = proto.link({}, Drawable, "src.proto.text")

---@generic S
---@param self S|src.proto.text
---@return S|src.proto.text self
function Text:init()
  if not self.colors then
    if self.parent.colors then
      self.colors = { self.parent.colors[1] .. "+2" }
    end
  end
  Drawable.init(self)
  self:update()
  return self
end

function Text:update()
  self.text_obj = lg.newText(self.parent.app.fonts.current, self.text)
  self.abs_size = { self.text_obj:getDimensions() }
  self:update_geometry()
  return self
end

function Text:draw()
  Drawable.draw(self)
  lg.draw(self.text_obj, unpack(self.abs_pos))
  return self
end

return Text
