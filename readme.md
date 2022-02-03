# LOVE-template (WIP)

This project is a minimal pixel-style game template based on [LÖVE][] engine.

![screenshot](res/img/examples/screenshot.png)

Notice: I preferred pixel art not just because I love this style, but first of
all because it is the key to high performance and low memory consumption, which
I highly appreciate. So, this is not just my taste preferences, but the primary
necessity. Some people call it "retro-style". They think the point is to try to
make user feel nostalgic, but really, I don't care about that. All that drives
me is the desire to write perfect code: control every pixel on the screen and
every byte of memory!

## Features (current and planned)

- Pixel-perfect and tile-based:
  - [x] Scaling
  - [ ] GUI
- Multiplayer:
  - [ ] Server
    - [ ] Database (sqlite?)
    - [ ] Communications (enet?)
      - [ ] Authorization
      - [ ] Lobby and chat
  - [ ] Tic-tac-toe ranking game
- Additional:
  - [x] Full documentation (sumneko-[lsp][])
  - [x] Very simple but powerful prototype-based OOP
  - [x] Preconfigured vscode-[debugger][]
  - [x] Advanced logging and debugging libs
  - [ ] Easy import grids and animations from [libresprite][]

## Pre-requirements

- love >11
- lua >5 or luajit >2
- luarocks >3

## Installation

- Fork this repo
- Clone your fork
- Install dependencies: `lua run/install.lua`
- Update submodules: `lua run/update.lua`

## Agreements

- Use formatters: [stylua][] for lua and [prettier][] for everything else.
- Use [luacheck] and [lsp] for errors detection.
- Prototypes must be named in CamelCase.
- Other variables must be named in snake_case.
- Start comments with capital letter and finish with dot.

[löve]: https://love2d.org
[stylua]: https://github.com/johnnymorganz/stylua
[prettier]: https://github.com/prettier/prettier
[luacheck]: https://github.com/mpeterv/luacheck
[lsp]: https://github.com/sumneko/lua-language-server
[debugger]: https://github.com/tomblind/local-lua-debugger-vscode
[libresprite]: https://libresprite.github.io
