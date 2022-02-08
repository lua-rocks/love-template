return {
  node = "rect",
  pos = { "50%8", "50%8" },
  size = { "50%8", "50%8" },
  on_init = function(self)
    self.image = self.app.skins.mc_gui_rect.atlas
    self:update_image()
  end,
  -- skin = "red",
}
