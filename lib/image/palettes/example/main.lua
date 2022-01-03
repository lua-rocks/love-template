local load_palettes = require("lib.image.palettes.load")
local swap_palettes = require("lib.image.palettes.swap")
local le = love.event

local dir = "res/img/examples/"

local palettes_map_image_path
local palettes_image_test

local palettes

local test_data
local test_img ---@type love.Image
local pal_img ---@type love.Image

local demo_switcher
local palette_index_start
local palette_index_now

local function next_demo()
  demo_switcher = not demo_switcher
  if demo_switcher then
    palettes_map_image_path = dir .. "palette-swapable.png"
    palettes_image_test = dir .. "palette-test.png"
    palette_index_start = 5
    palette_index_now = 5
  else
    -- palettes_map_image_path = dir .. "5colors-swapable.png"
    palettes_map_image_path = "res/img/palettes/db16/db16x5.png"
    palettes_image_test = dir .. "5colors-test.png"
    palette_index_start = 1
    palette_index_now = 1
  end
  palettes = load_palettes(palettes_map_image_path)
  test_data = love.image.newImageData(palettes_image_test)
  test_img = love.graphics.newImage(test_data)
  pal_img = love.graphics.newImage(palettes_map_image_path)
end

next_demo()

love.graphics.setBackgroundColor(unpack(palettes[palette_index_start][5]))

local function update_palette()
  local copy = test_data:clone()
  swap_palettes(
    copy,
    palettes[palette_index_start],
    palettes[palette_index_now]
  )
  test_img = love.graphics.newImage(copy)
end

function love.draw()
  love.graphics.scale(4)
  love.graphics.draw(test_img)
  love.graphics.scale(2)
  love.graphics.draw(pal_img, 40, 4)
end

love.keypressed = function(key)
  if key == "escape" then
    le.quit()
  elseif key == "up" then
    palette_index_now = palette_index_now - 1
    if palette_index_now < 1 then
      palette_index_now = 1
    else
      update_palette()
    end
  elseif key == "down" then
    palette_index_now = palette_index_now + 1
    if palette_index_now > #palettes then
      palette_index_now = #palettes
    else
      update_palette()
    end
  elseif key == "space" or key == "right" or key == "left" then
    next_demo()
  end
end
