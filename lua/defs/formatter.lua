local M = {}

-- expected to be in the form:
-- formatter name = { filetypes, ... }

M.formatter_ft = {
    prettierd = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "css",
        "scss",
        "markdown",
        "html"
    },
    isort = { "python" },
    black = { "pyhthon" },
    styleua = { "lua" },
    beautysh = { "bash" },
    rustfmt = { "rust" },
    yamlfix = { "yaml" },
    taplo = { "toml" },
}

return M
