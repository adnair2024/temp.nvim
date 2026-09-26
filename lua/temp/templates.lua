local M = {}

M.registry = {
    markdown = [[
---
title: "{{title}}"
date: {{date}}
draft: true
tags: []
---

# {{title}}
]],
    hugo_post = [[
+++
date = '{{timestamp}}'
draft = false
title = '{{title}}'
type = 'post'
tags = []
categories = []
+++

# {{title}}
]],
    python = [[
#!/usr/bin/env python3
"""
Author: Ash
Created: {{date}}
Description: {{title}}
"""

def main():
    pass

if __name__ == "__main__":
    main()
]]
}

function M.render(template_key, data)
    local template = M.registry[template_key]
    if not template then return nil end

    for key, value in pairs(data) do
        template = template:gsub("{{" .. key .. "}}", value)
    end

    return vim.split(template, "\n")
end

return M
