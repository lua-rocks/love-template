---@class src.app
---@field win src.app.win
---@field palettes src.app.palettes
---@field skins src.app.skins
---@field fonts src.app.fonts
---@field stack src.app.stack
local app = proto.set_name({}, "src.app")

---@generic S
---@param self S|src.app
---@return S|src.app self
function app:init()
  self.palettes = require("src.app.palettes")
  self.skins = require("src.app.skins"):init(self.palettes)
  self.win = require("src.app.win")
  self.win.app = self
  self.win:init()
  self.fonts = require("src.app.fonts"):init()
  self.stack = require("src.app.stack")
  self:load_scene("main")
  return self
end

---@param scene string
function app:load_scene(scene)
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
      self.stack:push(node)
    end
    return node
  end
  return parse(require("src.views." .. scene), self.win[1])
end

return app
