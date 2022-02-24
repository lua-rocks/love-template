---@type src.proto.text
local text = {
  node = "text",
  pos = { 8, 8 },
  expander = { 8, 8 },
  text = "У попа была собака,\nон её любил.\nОна съела кусок мяса...",
  colors = { "white", "brown" },
  shadow = true,
}

---@type src.proto.rect
local rect = {
  id = "#rect",
  node = "rect",
  pos = { "50%8", "50%8" },
  size = { 8, 8 }, -- Will be increased.
  skin = "orange",
  text,
  -- on_update = function(self, what)
  --   log.debug(what, inspect(self.abs_size))
  -- end,
}

return rect
