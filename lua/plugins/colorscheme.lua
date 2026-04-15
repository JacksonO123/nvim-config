local colorschemes = require("config.colorschemes").colorschemes
local settings = require("config.settings")
local active = settings.colorscheme
local res = {}

local found = false

for i = 1, table.getn(colorschemes) do
    local item = colorschemes[i]
    local priority = 0

    if item.name == active then
        found = true
        priority = 1000
    end

    res[i] = {
        item[1],
        lazy = item.name ~= active,
        priority = priority,
        enable = item.name == active,
        config = function()
            if item.name ~= active then
                return
            end

            item.config()
            vim.opt.termguicolors = true
            vim.cmd.colorscheme(item.name)
        end,
    }
end

if not found then
    vim.cmd.colorscheme(active)
end

return res
