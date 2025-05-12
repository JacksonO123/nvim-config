local M = {}

M.clients = {
  "lua_ls",
  "clangd",
  "ts_ls",
  "zls",
}

function M.setup_lsp()
  local lspconfig = require("lspconfig")

  for i = 1, table.getn(M.clients) do
    lspconfig[M.clients[i]].setup({})
  end
end

return M
