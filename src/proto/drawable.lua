local lg = love.graphics

---If `size` or `pos` is string, it can be one of these formats:
---
---+ "50%" = 50% of parent's value;
---+ "50%4" = 50% of parent's value, rounded by 4 pixels;
---+ "4x4" = 16 (convenient when you want to set value in tiles);
---+ "-5" = parent's value -5;
---+ "+5" or "5" = 5.
---
---FIXME: In "expander" values are currently always rounded by 4.
---
---@class src.proto.drawable
---@field app src.app
---@field parent src.proto.drawable
---@field root src.proto.drawable
---@field abs_size {[1]:number, [2]:number} Set it to nil to reload from `size`.
---@field abs_pos {[1]:number, [2]:number}
---@field rel_pos {[1]:number, [2]:number}
---@field updaters table<string, function>
---@field pos? {[1]:number|string, [2]:number|string}
---@field size? {[1]:number|string, [2]:number|string}
---@field colors? table<integer|string,string> Named colors.
---@field abs_colors? table<integer|string,lib.image.color> Real colors.
---@field closed? boolean Keep content in bounds.
---@field expander? boolean|{[1]?:number, [2]?:number} Increase parent's size.
---@field on_draw? fun(self:src.proto.drawable)
---@field on_init? fun(self:src.proto.drawable)
---@field on_hover? fun(self:src.proto.drawable)
---@field on_click? fun(self:src.proto.drawable)
---@field on_update? fun(self:src.proto.drawable, what:string)
---@field id? string
---@field name? string
---@field tags? string[]
local Drawable = proto.set_name({}, "src.proto.drawable")

Drawable.updaters = {
  size = function(self)
    if not self.size then
      return
    end
    local win = self.app.win
    local parent = self.parent
    for i = 1, 2 do
      if type(self.abs_size[i]) ~= "number" then
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
    end
  end,
  pos = function(self)
    if not self.pos then
      return
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
  end,
  expander = function(self)
    if not self.expander then
      return
    end
    if type(self.expander) == "boolean" then
      self.expander = { 0, 0 }
    end
    for i = 1, 2 do
      if self.expander[i] ~= nil then
        local size = self.rel_pos[i] + self.abs_size[i] + self.expander[i]
        size = math.ceil(size / 4) * 4
        if size > self.parent.abs_size[i] then
          self.parent.abs_size[i] = size
        end
        local pos = self.parent.abs_pos[i] - self.abs_pos[i]
        if pos > 0 then
          self.parent.abs_pos[i] = self.parent.abs_pos[i] - pos
          self.parent.abs_size[i] = self.parent.abs_size[i] + pos
        end
      end
    end
  end,
  colors = function(self)
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
  end,
  geometry = function(self)
    self:update("size")
    self:update("pos")
    self:update("expander")
  end,
  -- TODO: Make possible to use any updater recursive.
  geometry_recursive = function(self)
    self:update("geometry")
    for _, node in ipairs(self) do
      node:update("geometry_recursive")
    end
  end,
}

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
  self:update("colors")
  self:update("geometry")
  if self.on_init then
    self:on_init()
  end
  return self
end

---@return src.proto.drawable
function Drawable:draw()
  if self.abs_colors and self.abs_colors[1] then
    lg.setColor(unpack(self.abs_colors[1]))
  else
    lg.setColor(1, 1, 1)
  end
  if self.on_draw then
    self:on_draw()
  end
end

---@return src.proto.drawable
function Drawable:draw_recursive()
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
end

---@param what string Updater name.
---@return src.proto.drawable
function Drawable:update(what)
  for parent in proto.parents(self) do
    if parent.updaters and parent.updaters[what] then
      parent.updaters[what](self)
      if self.on_update then
        self.on_update(self, what)
      end
      return
    end
  end
end

return Drawable
