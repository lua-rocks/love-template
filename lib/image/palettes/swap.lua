local color2hex = require("lib.image.color.color2hex")

---Redraw ImageData with new palette.
---@param imgdata love.ImageData|string
---@param p1 lib.image.palette
---@param p2 lib.image.palette
return function(imgdata, p1, p2)
  if type(imgdata) == "string" then
    imgdata = love.image.newImageData(imgdata)
  end
  local colormap = {}
  for index, color in ipairs(p1) do
    colormap[color2hex(unpack(color))] = index
  end
  imgdata:mapPixel(function(_, _, r, g, b, a)
    local index = colormap[color2hex(r, g, b)]
    if index then
      return unpack(p2[index])
    end
    return r, g, b, a
  end)
end
