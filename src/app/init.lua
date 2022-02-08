---@class src.app
---@field win src.app.win
---@field palettes src.app.palettes
---@field skins src.app.skins
---@field fonts src.app.fonts
---@field stack src.app.stack
local app = proto.set_name({}, "src.app")

function app:init()
  self.palettes = require("src.app.palettes"):init()
  self.skins = require("src.app.skins"):init(self.palettes)
  self.fonts = require("src.app.fonts"):init()
  self.stack = require("src.app.stack")
  self.win = require("src.app.win")
  self.win.app = self
  self.win:init():load_view("main")
  return self
end

return app
