local setColorScheme = function(name)
    vim.cmd.colorscheme(name)
end

local colorschemes = require("config.colorschemes").colorschemes
local settings = require("config.settings")
local active = settings.colorscheme
local res = {}

for i = 1, table.getn(colorschemes) do
    local item = colorschemes[i]
    local priority = 0

    if item.name == active then
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
            setColorScheme(item.name)
        end
    }
end

return res
