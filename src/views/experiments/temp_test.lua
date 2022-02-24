---@type src.proto.text
local text = {
  node = "text",
  pos = { 8, 8 },
  expander = { nil, 8 },
  text = "У попа была собака,\nон её любил.\nОна съела кусок мяса...",
  colors = { "white", "brown" },
  shadow = true,
}

---@type src.proto.rect
local rect = {
  node = "rect",
  pos = { "25%8", "25%8" },
  size = { "16x8", "2x8" },
  skin = "orange",
  text,
}

return rect
