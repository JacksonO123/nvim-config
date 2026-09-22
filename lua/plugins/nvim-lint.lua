local function lint_buffer(bufnr)
    local settings = require("config.settings")
    local utils = require("utils.utils")
    local lint = require("lint")

    local linters = settings.linters_by_ft[vim.bo[bufnr].filetype]
    local cwd
    if type(linters) == "function" then
        linters, cwd = linters(bufnr)
    end

    if not linters or #linters == 0 then
        return
    end

    lint.try_lint(linters, {
        cwd = cwd,
        wrap_linter = function(linter)
            local bin = cwd and utils.find_node_bin(cwd, linter.name)
            if bin then
                linter.cmd = bin
            end
            return linter
        end,
    })
end

return {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = "VeryLazy",
    config = function()
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function(args)
                lint_buffer(args.buf)
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint_buffer(vim.api.nvim_get_current_buf())
        end, { desc = "Lint current file" })
    end,
}
