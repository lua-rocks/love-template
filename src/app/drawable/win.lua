local lg = love.graphics
local lw = love.window
local Drawable = require("src.app.drawable")
local Rect = require("src.app.drawable.gui.rect")

---@class src.app.drawable.win:src.app.drawable
---@field flags table
---@field scale integer
---@field parent nil
local win = proto.link({}, Drawable, "src.app.drawable.win")

---@generic S
---@param self S|src.app.drawable.win
---@return S|src.app.drawable.win self
function win:init()
  local colors = self.app.palettes.db16_name_to_color
  lg.setBackgroundColor(colors["rock"])
  local w, h, f = lw.getMode()
  self.flags = f
  self.pos = { 0, 0 }
  self.size = { w, h }
  self:resize(w, h)
  w, h = f.minwidth, f.minheight
  self.default_size = { w, h }
  local canvas = love.graphics.newCanvas(w, h)
  do -- Make background for root node:
    local scale = 8
    local temp_canvas = love.graphics.newCanvas(w / scale, h / scale)
    lg.setCanvas(temp_canvas)
    local points = {
      [false] = colors["silver"],
      [true] = colors["gray"],
    }
    local i = false
    for y = 0, h / scale do
      for x = 0, w / scale do
        lg.setColor(unpack(points[i]))
        lg.points(x, y)
        i = not i
      end
    end
    lg.setCanvas(canvas)
    lg.setColor(1, 1, 1)
    lg.scale(scale)
    lg.draw(temp_canvas)
    lg.setCanvas()
  end
  proto.new(Rect, { -- Create root node:
    parent = self,
    pos = { "50%", "50%" },
    size = self.default_size,
    image = canvas,
  })
  return self
end

function win:draw()
  lg.scale(self.scale)
  return self
end

function win:draw_all()
  Drawable.draw_all(self)
end

---@param w number
---@param h number
function win:resize(w, h)
  self.scale = math.floor(
    math.min(w / self.flags.minwidth, h / self.flags.minheight)
  )
  self.size[1] = math.floor(w / self.scale)
  self.size[2] = math.floor(h / self.scale)
  self:update_all()
  return self
end

function win:keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
  return self, key
end

return win
