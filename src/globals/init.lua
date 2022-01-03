-- luacheck: no global

package.path = package.path
  .. ";src/?/init.lua;lib/?/init.lua"
  .. ";src/?.lua;lib/?.lua"

lume = require("lume")
proto = require("proto")
