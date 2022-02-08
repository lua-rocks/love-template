local new_quad = love.graphics.newQuad

---This library has a tools for convenient working with image-atlases,
---It makes possible to create a grid on the image and take quads from it.
---
---As pixel-art editor I recommend [libresprite](https://libresprite.github.io).
---You can very easy pick grid coordinates from it.
---
---@class lib.image.grid
---@field image_size {[1]:number,[2]:number}
---@field quad_size {[1]:number,[2]:number}
---@field grid_pos? {[1]:number,[2]:number}
local Grid = proto.set_name({}, "lib.image.grid")

---Get single quad by position or rectangle selection
---@param x1 integer X or left corner X
---@param y1 integer Y or left corner Y
---@param x2? integer Right corner X or `x1`
---@param y2? integer Right corner Y or `y1`
---@return love.Quad
function Grid:get_quad(x1, y1, x2, y2)
  x2 = (x2 or x1) - x1 + 1
  y2 = (y2 or y1) - y1 + 1
  local iw, ih = unpack(self.image_size)
  local qw, qh = unpack(self.quad_size)
  local gx, gy = unpack(self.grid_pos or { 0, 0 })
  local qx, qy = gx + x1 * qw, gy + y1 * qh
  return new_quad(qx, qy, qw * x2, qh * y2, iw, ih)
end

---Iterator for rectangle selection of quads
---@param x1 integer Left corner X
---@param y1 integer Left corner Y
---@param x2? integer Right corner X or `x1`
---@param y2? integer Right corner Y or `y1`
---@return fun(): love.Quad, integer, integer
function Grid:quads(x1, y1, x2, y2)
  x2 = x2 or x1
  y2 = y2 or y1
  local iw, ih = unpack(self.image_size)
  local qw, qh = unpack(self.quad_size)
  local gx, gy = unpack(self.grid_pos or { 0, 0 })
  local x, y, max_x, max_y = 0, 1, x2 - x1 + 1, y2 - y1 + 2
  local function next_iter()
    if y < max_y then
      if x < max_x then
        x = x + 1
        local qx, qy = gx + (x1 + x - 1) * qw, gy + (y1 + y - 1) * qh
        return new_quad(qx, qy, qw, qh, iw, ih), x, y
      else
        x = 0
        y = y + 1
        return next_iter()
      end
    end
  end
  return next_iter
end

---@param x? integer
---@param y? integer
---@param w? integer
---@param h? integer
function Grid:tiles2pixels(x, y, w, h)
  x = x or 0
  y = y or 0
  w = w or 0
  h = h or 0
  local gx, gy = unpack(self.grid_pos or { 0, 0 })
  local qw, qh = unpack(self.quad_size)
  w, h = (w + 1) * qw, (h + 1) * qh
  x, y = x * w * gx, y * h * gy
  return x, y, w, h
end

return Grid
