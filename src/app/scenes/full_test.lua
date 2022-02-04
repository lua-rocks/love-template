return {
  node = "gui.rect",
  pos = { "50%8", "50%8" },
  size = { "12x8", "6x8" },
  skin = "orange",
  {
    node = "gui.text",
    pos = { 4, 4 },
    align = "right",
    limit = 4,
    on_draw = function(self)
      self.text = "Current FPS: " .. love.timer.getFPS() .. "/100"
    end,
  },
}
