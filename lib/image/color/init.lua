---@class lib.image.color
---@field [1] number r
---@field [2] number g
---@field [3] number b
---@field [4]? number a

return {
  color2hex = require("lib.image.color.color2hex"),
  hex2color = require("lib.string").color,
}
