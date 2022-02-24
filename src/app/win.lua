local lg = love.graphics
local lw = love.window
local Drawable = require("src.proto.drawable")
local Rect = require("src.proto.rect")

---@class src.app.win:src.proto.drawable
---@field flags table
---@field scale integer
---@field parent nil
---@field hovered src.proto.drawable Element under mouse cursor right now.
local win = proto.link({}, Drawable, "src.app.win")

local function make_root_node(self, w, h)
  local colors = self.app.palettes.name_to_color
  lg.setBackgroundColor(colors["rock"])
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
  proto.new(Rect, {
    parent = self,
    closed = true,
    pos = { "50%", "50%" },
    size = self.size,
    image = canvas,
  })
end

function win:init()
  local w, h, f = lw.getMode()
  self.flags = f
  self.abs_pos = { 0, 0 }
  self.abs_size = { w, h }
  self:resize(w, h)
  w, h = f.minwidth, f.minheight
  self.size = { w, h }
  make_root_node(self, w, h)
  self:load_view("main")
  self:update("geometry_recursive")
  return self
end

---@param view string
function win:load_view(view)
  local function parse(t, parent)
    local forbidden = { drawable = true, skin = true }
    if forbidden[t.node] then
      error("wrong node: " .. tostring(t.node))
    end
    t.parent = parent
    local Node = require("src.proto." .. t.node)
    t.node = nil
    local conf = {}
    for key, value in pairs(t) do
      if type(key) == "string" then
        conf[key] = value
      end
    end
    local node = proto.new(Node, conf)
    for _, value in ipairs(t) do
      parse(value, node)
    end
    if node.on_hover or node.on_click then
      self.app.stack:push(node)
    end
    return node
  end
  return parse(require("src.views." .. view), self[1])
end

function win:draw()
  lg.scale(self.scale)
  return self
end

function win:draw_recursive()
  Drawable.draw_recursive(self)
end

---@param w number
---@param h number
function win:resize(w, h)
  self.scale = math.floor(
    math.min(w / self.flags.minwidth, h / self.flags.minheight)
  )
  self.abs_size[1] = math.floor(w / self.scale)
  self.abs_size[2] = math.floor(h / self.scale)
  self:update("geometry_recursive")
  return self
end

function win:keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
  return self, key
end

function win:mousemoved(x, y)
  local hovered_before = self.hovered
  local hovered_after = self.app.stack:touch({ x / self.scale, y / self.scale })
  if hovered_before == hovered_after then
    return
  end
  if hovered_before and hovered_before.on_hover then
    hovered_before:on_hover(false)
  end
  if hovered_after and hovered_after.on_hover then
    hovered_after:on_hover(true)
  end
  self.hovered = hovered_after
end

function win:mousepressed(x, y, button)
  local clicked = self.app.stack:touch({ x / self.scale, y / self.scale })
  if clicked and clicked.on_click then
    clicked:on_click(button)
  end
end

return win
