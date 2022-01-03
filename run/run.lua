print("\n===================RUN==================\n")

-- luacheck: no unused

package.path = "?/init.lua;" .. package.path

local function run_and_dump_crash_logs()
  local execute = require("lib.os.execute")
  local _, result = pcall(execute, "love .")

  local crash = tostring(result):match("Error:.+")

  local log = require("lib.any.log")

  print(result)

  if crash then
    log.outfile = "log/crash.log"
    log.fatal(crash)
  end
end

local function run_simple()
  os.execute("love .")
end

run_simple()
