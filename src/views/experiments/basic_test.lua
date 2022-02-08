return {
  node = "rect",
  pos = { 16, 16 },
  size = { "50%4", "50%4" },
  skin = "red",
  on_hover = function(self, on)
    if on then
      self.colors[1] = "grass"
      self:update_colors()
      self.skin = "grass"
      self:update_image()
    else
      self.colors[1] = "red"
      self:update_colors()
      self.skin = "red"
      self:update_image()
    end
  end,
  {
    node = "rect",
    pos = { "50%4", "50%4" },
    size = { "16x4", "8x4" },
    skin = "orange",
    on_hover = function(self, on)
      if on then
        self[1].text = "Hi! :3"
        self[1]:update()
      else
        self[1].text = "Bye! :<"
        self[1]:update()
      end
    end,
    on_click = function(self, button)
      self[1].text = button
      self[1]:update()
    end,
    {
      node = "text",
      pos = { "50%", "50%" },
      on_init = function(self)
        self.text = "Привет?"
        self:update()
      end,
    },
  },
}
