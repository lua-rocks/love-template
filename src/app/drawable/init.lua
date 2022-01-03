local lg = love.graphics

---@class src.app.drawable
---@field app src.app
---@field parent src.app.drawable
---@field root src.app.drawable
---@field size {[1]:number, [2]:number}
---@field pos {[1]:number, [2]:number}
---@field default_size? {[1]:number, [2]:number}
---@field default_pos? {[1]:number, [2]:number}
---@field colors? table<integer|string,string> Named colors.
---@field _colors? table<integer|string,lib.image.color> Real colors.
---@field batches? table<integer|string,love.SpriteBatch>
---@field id? string
---@field name? string
---@field tags? table
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
  self.default_pos = { unpack(self.pos) }
  if self.size then
    self.default_size = { unpack(self.size) }
    self.size = proto.copy(self.default_size)
  end
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
  self:update()
  return self
end

function drawable:draw()
  return self
end

function drawable:draw_all()
  if self._colors and self._colors[1] then
    lg.setColor(unpack(self._colors[1]))
  else
    lg.setColor(1, 1, 1)
  end
  self:draw()
  for _, node in ipairs(self) do
    node:draw_all()
  end
  return self
end

function drawable:update()
  local parent = self.parent
  local pattern = "(%d+)(%D*)(%d*)"
  if self.default_size then
    for i = 1, 2 do
      local def_i = self.default_size[i]
      if type(def_i) == "string" then
        local n1, s, n2 = def_i:match(pattern)
        if s == "%" then
          local prc = n1 * 0.01
          self.size[i] = math.floor(parent.size[i] * prc)
        elseif s == "x" then
          self.size[i] = n1 * n2
        else
          self.size[i] = n1
        end
      end
    end
  end
  if self.default_pos then
    for i = 1, 2 do
      local def_i = self.default_pos[i]
      if type(def_i) == "string" then
        local n1, s, n2 = def_i:match(pattern)
        if s == "%" then
          local prc = n1 * 0.01
          n1 = math.floor(parent.size[i] * prc - self.size[i] * prc)
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

function drawable:update_all()
  self:update()
  for _, node in ipairs(self) do
    node:update_all()
  end
  return self
end

return drawable
