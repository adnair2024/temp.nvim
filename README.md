# temp.nvim
A zero-dependency Neovim plugin that instantly injects custom templates and frontmatter into your buffers with an interactive prompt.

## Installation (lazy.nvim)

```lua
{
    dir = "~/Projects/temp.nvim", -- or your repo path
    config = function()
        require("temp").setup()
    end,
}

*Note: This was designed for Neovim 0.7 and above.*
