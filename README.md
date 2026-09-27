# temp.nvim

[![Neovim](https://img.shields.io/badge/Neovim-0.7+-57A143?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](https://opensource.org/licenses/MIT)

Minimal Neovim plugin for inserting templates and frontmatter into new buffers.

## Requirements

- Neovim >= 0.7.0

## Installation

### lazy.nvim

```lua
{
  "adnair2024/temp.nvim",
  cmd = "Temp",
  config = function()
    require("temp").setup()
  end,
}
```

Or for local development:

```lua
{
  dir = "~/Projects/temp.nvim",
  cmd = "Temp",
  config = function()
    require("temp").setup()
  end,
}
```

### packer.nvim

```lua
use {
  "adnair2024/temp.nvim",
  config = function()
    require("temp").setup()
  end,
}
```

## Usage

Run `:Temp` inside any buffer:

```vim
:Temp
```

`temp.nvim` selects a template based on the current buffer:
- Files under `content/post/` or `blog/` use `hugo_post`.
- Other files default to their `&filetype` (e.g. `python`, `markdown`).

You can also pass a template name directly with tab completion:

```vim
:Temp hugo_post
:Temp python
:Temp markdown
```

When invoked, `vim.ui.input` prompts for a title (prefilled with the filename, stripping hyphens). Press `<Enter>` to insert the rendered template at the top of the buffer.

### Keymap

```lua
vim.keymap.set("n", "<leader>tp", "<cmd>Temp<CR>", { desc = "Insert template" })
```

## Built-in Templates

- **`markdown`**: YAML frontmatter (`title`, `date`, `draft: true`, `tags: []`) and title heading.
- **`hugo_post`**: TOML frontmatter (`date`, `draft = false`, `title`, `type = 'post'`) and title heading.
- **`python`**: File header docstring and boilerplate `main()` entrypoint.

### Variables

Templates replace the following placeholders upon insertion:

- `{{title}}`: Title entered at the prompt.
- `{{date}}`: Current date (`YYYY-MM-DD`).
- `{{timestamp}}`: Current ISO 8601 timestamp with timezone offset.

## License

MIT
