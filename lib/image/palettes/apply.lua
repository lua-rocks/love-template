local swap = require("lib.image.palettes.swap")
local new_imgdata = love.image.newImageData

---Redraw imgdata using all provided palettes and extending it vertically.
---@param imgdata love.ImageData|string
---@param palette lib.image.palette Original palette.
---@param palettes lib.image.palette[] Another palettes.
---@return love.ImageData
return function(imgdata, palette, palettes)
  if type(imgdata) == "string" then
    imgdata = new_imgdata(imgdata)
  end
  local w, h = imgdata:getDimensions()
  local n = #palettes
  local result = new_imgdata(w, h * n)
  for i, p in ipairs(palettes) do
    local clone = imgdata:clone()
    swap(clone, palette, p)
    result:paste(clone, 0, (i - 1) * h, 0, 0, w, h)
  end
  return result
end
