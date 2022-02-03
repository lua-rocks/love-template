local lg = love.graphics

---If `size` or `pos` is string, it can be one of these formats:
---
---+ "50%" = 50% of parent's value;
---+ "50%4" = 50% of parent's value, rounded by 4 pixels;
---+ "4x4" = 16 (convenient when you want to set value in tiles).
---@class src.app.drawable
---@field app src.app
---@field parent src.app.drawable
---@field root src.app.drawable
---@field size {[1]:number, [2]:number}
---@field pos {[1]:number, [2]:number}
---@field default_size? {[1]:number|string, [2]:number|string}
---@field default_pos? {[1]:number|string, [2]:number|string}
---@field colors? table<integer|string,string> Named colors.
---@field _colors? table<integer|string,lib.image.color> Real colors.
---@field batches? table<integer|string,love.SpriteBatch>
---@field id? string
---@field name? string
---@field tags? table
---@field content? '"wrap"'|'"expand"'|'"inside"'|'"outside"' = `"outside"`
---@field on_draw fun(self:src.app.drawable)
local drawable = proto.set_name({}, "src.app.drawable")

---@generic S
---@param self S|src.app.drawable
---@return S|src.app.drawable self
function drawable:init()
  local parent = self.parent
  self.app = parent.app or parent ---@type src.app
  table.insert(parent, self)
  self.root = self.parent.root or self
  self.pos = self.pos or { 0, 0 }
  self.default_pos = proto.copy(self.pos)
  if self.size then
    self.default_size = proto.copy(self.size)
  end
  self:update_colors()
  self:update_coords()
  return self
end

function drawable:draw()
  if self.on_draw then
    self:on_draw()
  end
  return self
end

function drawable:draw_all()
  if self._colors and self._colors[1] then
    lg.setColor(unpack(self._colors[1]))
  else
    lg.setColor(1, 1, 1)
  end
  self:draw()
  local function draw_nodes()
    for _, node in ipairs(self) do
      node:draw_all()
    end
  end
  if self.content == "inside" then
    local x, y = unpack(self.pos)
    local w, h = unpack(self.size)
    local s = self.app.win.scale
    lg.setScissor(x * s, y * s, w * s, h * s)
    draw_nodes()
    lg.setScissor()
  else
    draw_nodes()
  end
  return self
end

function drawable:update_colors()
  self.colors = self.colors or { "white" }
  self._colors = {}
  local pal = self.app.palettes
  for key, color in pairs(self.colors) do
    if type(color) == "string" then
      local c, swap, by = string.match(color, "(.-)([%+%-])(%d+)")
      if c and swap and by then
        local i = pal.db16_name_to_index[c]
        by = tonumber(by)
        if swap == "+" then
          self._colors[key] = pal.db16[5 + by][i]
        elseif swap == "-" then
          self._colors[key] = pal.db16[5 - by][i]
        else
          error("wrong color")
        end
      else
        self._colors[key] = pal.db16_name_to_color[color]
      end
    end
  end
end

function drawable:update_coords()
  local parent = self.parent
  local pattern = "(%d+)(%D*)(%d*)"
  if self.default_size then
    for i = 1, 2 do
      local def_i = self.default_size[i]
      if type(def_i) == "string" then
        local n1, s, n2 = def_i:match(pattern)
        n2 = tonumber(n2)
        if s == "%" then
          local prc = n1 * 0.01
          n1 = math.floor(parent.size[i] * prc)
          if n2 then
            n1 = math.floor(n1 / n2) * n2
          end
        elseif s == "x" then
          n1 = n1 * n2
        end
        self.size[i] = n1
      end
    end
  end
  if self.default_pos then
    for i = 1, 2 do
      local def_i = self.default_pos[i]
      if type(def_i) == "string" then
        local n1, s, n2 = def_i:match(pattern)
        n2 = tonumber(n2)
        if s == "%" then
          local prc = n1 * 0.01
          n1 = math.floor(parent.size[i] * prc - self.size[i] * prc)
          if n2 then
            n1 = math.floor(n1 / n2) * n2
          end
        elseif s == "x" then
          n1 = n1 * n2
        end
        self.pos[i] = n1 + parent.pos[i]
      else
        self.pos[i] = def_i + parent.pos[i]
      end
    end
  end
  return self
end

function drawable:update_all_coords()
  self:update_coords()
  for _, node in ipairs(self) do
    node:update_all_coords()
  end
  return self
end

return drawable
