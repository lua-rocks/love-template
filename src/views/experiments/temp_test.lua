---@type src.proto.text
local text = {
  node = "text",
  pos = { 8, 8 },
  text = "У попа была собака, он её любил. Она съела кусок мяса...",
  colors = { "white", "brown" },
  shadow = true,
  wrap = true, -- XXX
}

---@type src.proto.rect
local rect = {
  id = "#rect",
  node = "rect",
  pos = { "50%8", "50%8" },
  size = { 128, 64 },
  skin = "water",
  -- closed = true,
  text,
  -- on_update = function(self, what)
  --   log.debug(what, inspect(self.abs_size))
  -- end,
}

return rect
