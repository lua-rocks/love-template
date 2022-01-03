local lg = love.graphics
local image = lg.newImage("res/img/examples/tilesheet.png")
local Grid = require("lib.image.grid")

local grid = proto.new(Grid, {
  image_size = { image:getDimensions() },
  quad_size = { 8, 8 },
})

local face_quad = grid:get_quad(5, 9)
local tree_quad = grid:get_quad(1, 6, 2, 7)
local tree_batch = love.graphics.newSpriteBatch(image)
for quad, x, y in grid:quads(6, 0, 8, 4) do
  tree_batch:add(quad, (x - 1) * 8, (y - 1) * 8)
end

function love.draw()
  lg.scale(4)
  lg.draw(tree_batch, 0, 0)
  lg.draw(image, tree_quad, 24, 0)
  lg.draw(image, face_quad, 0, 0)
end
