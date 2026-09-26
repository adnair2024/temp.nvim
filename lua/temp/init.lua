local templates = require("temp.templates")
local M = {}

local function insert_template(template_type)
    -- First check if we are using a blog path, if not check the filetype
    local ft = vim.bo.filetype
    local chosen_template = template_type

    if not chosen_template or chosen_template == "" then
        -- Find default based on file type
        local current_file = vim.fn.expand("%:p")
        if current_file:match("content/post") or current_file:match("blog") then
            chosen_template = "hugo_post"
        else 
            chosen_template = ft ~= "" and ft or "markdown"
        end
    end

    local default_filename = vim.fn.expand("%:t:r")
    local default_title = default_filename ~= "" and default_filename:gsub("-", " ")

    vim.ui.input({
        prompt = "Template Title (" .. chosen_template .. "): ",
        default = default_title,
    }, function (input) 
        if not input then return end

        local data = {
            title = input,
            date = os.date("%Y-%m-%d")
            timestamp = os.date("%Y-%m-%dT%H:%M:%S-06:00")
    }

    local lines = templates.render(chosen_template, data)
    if not lines then
        vim.notify("No template found for key: " .. chosen_template, vim.log.levels.WARN)
        return
    end

    vim.api.nvim_buf_set_lines(0,0,0,false,lines)

        end)
end

function M.setup(opts)
    -- Register commmand allows a template argument (optional) like :Temp hugo_post
    vim.api.nvim_create_user_command("Temp", function(args)
        insert_template(args.args)
    end, {
            nargs = "?"
            complete = function()
                local keys = {}
            for k, _in pairs(templates.registry) do 
                table.insert(keys, k)
            end
            return keys
        end
        })
end

return M

