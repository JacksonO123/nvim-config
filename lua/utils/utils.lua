local M = {}

function M.get_js_formatter()
    local prettier_files = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.toml",
        ".prettierrc.js",
        "prettier.config.js",
        "prettier.config.mjs",
        "prettier.config.cjs",
        ".prettierrc.json5",
    }

    for _, f in ipairs(prettier_files) do
        local found = vim.fn.findfile(f, vim.fn.expand("%:p:h") .. ";")
        if found ~= "" then
            return "prettier"
        end
    end

    return "oxfmt"
end

return M
