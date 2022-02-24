return {
  node = "rect",
  pos = { 16, 16 },
  size = { "50%4", "50%4" },
  skin = "red",
  on_hover = function(self, on)
    if on then
      self.colors[1] = "grass"
      self:update("colors")
      self.skin = "grass"
      self:update("image")
    else
      self.colors[1] = "red"
      self:update("colors")
      self.skin = "red"
      self:update("image")
    end
  end,
  {
    node = "rect",
    pos = { "50%4", "50%4" },
    size = { "16x4", "8x4" },
    skin = "gray",
    on_hover = function(self, on)
      if on then
        self[1].text = "Hi! :3"
        self[1]:update("text")
      else
        self[1].text = "Bye! :<"
        self[1]:update("text")
      end
    end,
    on_click = function(self, button)
      self[1].text = button
      self[1]:update("text")
    end,
    {
      node = "text",
      pos = { "50%", "50%" },
      colors = { "white", "black-1" },
      shadow = true,
      on_init = function(self)
        self.text = "Привет!?"
        self:update("text")
      end,
    },
  },
}
