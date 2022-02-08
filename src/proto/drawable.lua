local lg = love.graphics

---If `size` or `pos` is string, it can be one of these formats:
---
---+ "50%" = 50% of parent's value;
---+ "50%4" = 50% of parent's value, rounded by 4 pixels;
---+ "4x4" = 16 (convenient when you want to set value in tiles);
---+ "-5" = parent's value -5;
---+ "+5" or "5" = 5.
---@class src.proto.drawable
---@field app src.app
---@field parent src.proto.drawable
---@field root src.proto.drawable
---@field abs_size {[1]:number, [2]:number}
---@field abs_pos {[1]:number, [2]:number}
---@field rel_pos {[1]:number, [2]:number}
---@field pos? {[1]:number|string, [2]:number|string}
---@field size? {[1]:number|string, [2]:number|string}
---@field colors? table<integer|string,string> Named colors.
---@field abs_colors? table<integer|string,lib.image.color> Real colors.
---@field closed? boolean Keep content in bounds.
---@field expander? boolean Increase parent's size if needed.
---@field on_draw? fun(self:src.proto.drawable)
---@field on_init? fun(self:src.proto.drawable)
---@field on_hover? fun(self:src.proto.drawable)
---@field on_click? fun(self:src.proto.drawable)
local Drawable = proto.set_name({}, "src.proto.drawable")

function Drawable:init()
  local parent = self.parent
  self.app = parent.app or parent ---@type src.app
  table.insert(parent, self)
  self.root = parent.root or self
  if not self.pos then
    self.rel_pos = { 0, 0 }
    self.abs_pos = self.parent.abs_pos
  else
    self.rel_pos = proto.copy(self.pos)
    self.abs_pos = proto.copy(self.rel_pos)
  end
  if self.size then
    self.abs_size = proto.copy(self.size)
  else
    self.abs_size = { 0, 0 }
  end
  self:update_colors()
  self:update_geometry()
  if self.on_init then
    self:on_init()
  end
  return self
end

function Drawable:draw()
  if self.on_draw then
    self:on_draw()
  end
  return self
end

function Drawable:draw_recursive()
  if self.abs_colors and self.abs_colors[1] then
    lg.setColor(unpack(self.abs_colors[1]))
  else
    lg.setColor(1, 1, 1)
  end
  self:draw()
  local function draw_nodes()
    for _, node in ipairs(self) do
      node:draw_recursive()
    end
  end
  if self.closed then
    local x, y = unpack(self.abs_pos)
    local w, h = unpack(self.abs_size)
    local s = self.app.win.scale
    lg.setScissor(x * s, y * s, w * s, h * s)
    draw_nodes()
    lg.setScissor()
  else
    draw_nodes()
  end
  return self
end

function Drawable:update_geometry()
  self:update_size()
  self:update_pos()
  self:update_expand()
  return self
end

function Drawable:update_geometry_recursive()
  self:update_geometry()
  for _, node in ipairs(self) do
    node:update_geometry_recursive()
  end
  return self
end

function Drawable:update_size()
  if not self.size then
    return self
  end
  local win = self.app.win
  local parent = self.parent
  for i = 1, 2 do
    local size_i = self.size[i]
    if type(size_i) == "string" then
      local s1, n1, s2, n2 = size_i:match("(%D-)(%d+)(%D*)(%d*)")
      n2 = tonumber(n2)
      if s2 == "%" then
        local prc = n1 * 0.01
        n1 = math.floor(parent.abs_size[i] * prc)
        if n2 then
          n1 = math.floor(n1 / n2) * n2
        end
      elseif s2 == "x" then
        n1 = n1 * n2
      end
      if s1 == "-" then
        n1 = self.parent.abs_size[i] - n1
      end
      self.abs_size[i] = n1
    elseif self ~= win then
      self.abs_size[i] = size_i
    end
  end
  return self
end

function Drawable:update_pos()
  if not self.pos then
    return self
  end
  local win = self.app.win
  local parent = self.parent
  for i = 1, 2 do
    local self_pos_i = self.pos[i]
    local parent_abs_pos_i = parent.abs_pos[i]
    if type(self_pos_i) == "string" then
      local s1, n1, s2, n2 = self_pos_i:match("(%D-)(%d+)(%D*)(%d*)")
      n2 = tonumber(n2)
      if s2 == "%" then
        local prc = n1 * 0.01
        n1 = math.floor(parent.abs_size[i] * prc - self.abs_size[i] * prc)
        if n2 then
          n1 = math.floor(n1 / n2) * n2
        end
      elseif s2 == "x" then
        n1 = n1 * n2
      end
      if s1 == "-" then
        n1 = self.parent.abs_size[i] - n1
      end
      self.rel_pos[i] = n1
      self.abs_pos[i] = n1 + parent_abs_pos_i
    elseif self ~= win then
      self.rel_pos[i] = self_pos_i
      self.abs_pos[i] = self_pos_i + parent_abs_pos_i
    end
  end
  return self
end

function Drawable:update_expand()
  if not self.expander then
    return self
  end
  for i = 1, 2 do
    local size = self.rel_pos[i] + self.abs_size[i]
    if size > self.parent.abs_size[i] then
      self.parent.abs_size[i] = size
      self.parent:update_expand()
    end
    local pos = self.parent.abs_pos[i] - self.abs_pos[i]
    if pos > 0 then
      self.parent.abs_pos[i] = self.parent.abs_pos[i] - pos
      self.parent.abs_size[i] = self.parent.abs_size[i] + pos
      self.parent:update_expand()
    end
  end
  return self
end

function Drawable:update_colors()
  self.colors = self.colors or { "white" }
  self.abs_colors = {}
  local pal = self.app.palettes
  for key, color in pairs(self.colors) do
    if type(color) == "string" then
      local c, swap, by = string.match(color, "(.-)([%+%-])(%d+)")
      if c and swap and by then
        local i = pal.name_to_index[c]
        by = tonumber(by)
        if swap == "+" then
          self.abs_colors[key] = pal[5 + by][i]
        elseif swap == "-" then
          self.abs_colors[key] = pal[5 - by][i]
        else
          error("wrong color")
        end
      else
        self.abs_colors[key] = pal.name_to_color[color]
      end
    end
  end
  return self
end

return Drawable
