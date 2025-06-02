local M = {}

local clients = require("defs.lsp").clients

function M.setup_lsp()
  local lspconfig = require("lspconfig")

  for i = 1, table.getn(clients) do
    lspconfig[clients[i]].setup({})
  end
end

return M
