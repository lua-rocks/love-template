# Tasks

- [ ] GUI
  - [x] Modify size and pos on fly
  - [x] Different ways to draw content in nodes
    - [x] Inside
    - [x] Outside
    - [x] Expand
    - [x] Text: Wrap
      - [ ] Better wrap
  - [x] Events
    - [x] `on_init`
    - [x] `on_draw`
    - [x] `on_hover`
    - [x] `on_click`
    - [ ] More events
    - [ ] Use `stack.pop()`
  - [ ] **Optimize palettes**
    - All coloring options should be drawn directly on the atlas, because:
      1. Auto-expanding atlas size or adding layers is inconvenient and
         problematic.
      2. This solution is not only easier, but also faster and more efficient.
  - [ ] **Text forms**
  - [ ] Checkboxes
  - [ ] Dragable and dropable
    - [ ] Content scrolling
- [ ] Server
  - [ ] DB (sqlite?)
  - [ ] Communication (enet?)
  - [ ] Registration
  - [ ] Authorization
- [ ] Create new libs for love
  - [ ] Animations (both types):
    - [ ] From libresprite
    - [ ] By atlas
  - [ ] Separate lume to different modules
