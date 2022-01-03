# Lua template

This template is designed for any lua-based projects and using [emmylua][]
format compatible with [sumneko-language-server][].

## Pre-requirements

+ lua >5 or luajit >2
+ luarocks >3

## Installation

+ Fork this repo
+ Clone your fork
+ Install dependencies: `lua run/install.lua`
+ Update submodules: `lua run/update.lua`

## Branches

+ **[main][]** - for pure lua project
+ **[love][]** - for [LÖVE](https://www.love2d.org)-based project
+ **[tic80][]** - for [TIC-80](https://github.com/nesbox/TIC-80)-based project

[main]: https://github.com/lua-rocks/lua-template/tree/main
[love]: https://github.com/lua-rocks/lua-template/tree/love
[tic80]: https://github.com/lua-rocks/lua-template/tree/tic80

## Content

### Libraries

+ **[inspect][]** - variable inspector
+ **[lume][]** - collection of first-needed functions
+ **[proto][]** - prototype-based oop library

[inspect]: https://github.com/kikito/inspect.lua
[lume]: https://github.com/rxi/lume
[proto]: https://github.com/lua-rocks/proto

### Tools and configs

+ **[emmylua][]** - all libraries are documented
+ **[luacheck][]** - configured to ignore warnings from 3d-party libs
+ **[vscode][]** - configured to build and run project on single keypress
+ **[sty-lua][]** - configured to keep all code in same style
+ **[lua-debugger][]** - configured for lua and love

[luacheck]: https://github.com/mpeterv/luacheck
[vscode]: https://vscodium.com
[emmylua]: https://git.io/JST0j

## Highly recommended vscode extensions

+ **[luacheck](https://is.gd/wDyiFS)**
+ **[sumneko-language-server][]**
+ **[lua-debugger][]**
+ **[sty-lua][]**
+ **[markdown-all-in-one](https://is.gd/Vau37L)**
+ **[markdown-lint](https://is.gd/2s8Dfz)**
+ **[markdown-reflow](https://is.gd/64eNeg)**

[sumneko-language-server]: https://is.gd/JiUVQe
[sty-lua]: https://is.gd/CJhdNt
[lua-debugger]: https://is.gd/Eo8rSX
