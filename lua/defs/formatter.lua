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
  },
  styleua = { "lua" },
  htmlbeautifier = { "html" },
  beautysh = { "bash" },
  rustfmt = { "rust" },
  yamlfix = { "yaml" },
  taplo = { "toml" },
}

return M
