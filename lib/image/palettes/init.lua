---@alias lib.image.palette lib.image.color[]
---@alias lib.image.palettes lib.image.palette[]

return {
  load = require("lib.image.palettes.load"),
  swap = require("lib.image.palettes.swap"),
  apply = require("lib.image.palettes.apply"),
}
