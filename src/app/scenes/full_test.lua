return {
  node = "gui.rect",
  pos = { 32, 32 },
  size = { "50%8", "12x8" },
  skin = "orange",
  content = "outside", -- "wrap"|"expand"|"inside"|"outside"
  {
    node = "gui.rect",
    pos = { "130%8", "50%8" },
    size = { "50%8", "50%8" },
    skin = "grass",
    {
      node = "gui.text",
      pos = { 4, 4 },
      text = "This window does not fit in the parent window :(",
    },
  },
  {
    node = "gui.text",
    pos = { 4, 4 },
    text = "Hello!",
    on_draw = function(self)
      self.text = "FPS: " .. love.timer.getFPS() .. "/120"
      self:update()
    end,
  },
}
