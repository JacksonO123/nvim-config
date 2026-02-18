local M = {}

local icons = require("lua.defs.icons")
M.icons = icons

M.map_leader = " "
M.map_local_leader = "\\"

-- M.format_on_save = true
M.format_on_save = false

M.tab_width = 2;

M.transparent = true
M.colorscheme = "kanagawa-paper"

M.formatter_ft = {
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    markdown = { "prettierd" },
    html = { "prettierd" },

    python = { "isort", "black" },
    lua = { "styleua" },
    bash = { "beautysh" },
    rust = { "rustfmt" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
}

M.format_ops = {
    lsp_format = "fallback",
    timeout_ms = 500,
}

M.lsp_clients = {
    "lua_ls",
    "ts_ls",
    "clangd",
    "zls",
    "rust_analyzer",
    "jsonls",
    "bashls",
    "tailwindcss",
    "pyright",
    "cssls",
    "jdtls",
    "eslint"
}

return M
