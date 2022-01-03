---Load palette from ImageData.
---@param imgdata love.ImageData|string
---@return lib.image.palettes
return function(imgdata)
  if type(imgdata) == "string" then
    imgdata = love.image.newImageData(imgdata)
  end
  local w, h = imgdata:getDimensions()
  local palettes = {}
  for y = 1, h do
    palettes[y] = {}
    for x = 1, w do
      palettes[y][x] = { imgdata:getPixel(x - 1, y - 1) }
    end
  end
  return palettes
end
