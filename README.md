# desktop-notify.nvim
Show desktop notifications for vim.notify calls

## Requirements

- `neovim 0.5+`
- `plenary.nvim`

## Supported platforms
- Linux (notify-send)

## Installation

using `packer.nvim`

```lua
use 'nvim-lua/plenary.nvim'
use 'simrat39/desktop-notify.nvim'
```

## Usage

```lua
-- Overrides vim.notify
require("desktop-notify").override_vim_notify()

-- Or, plugin authors/users can use it to send desktop notifications for
-- background tasks. The function works the same way as vim.notify.

require("desktop-notify").notify("Your message here")
```
