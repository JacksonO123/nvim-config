return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 999,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lsp_utils = require("utils.lsp")

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        automatic_enable = {},
        ensure_installed = lsp_utils.clients,
      })

      lsp_utils.setup_lsp()

      -- lsp borders
      local border_style = "rounded"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border_style })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = border_style }
      )
      vim.diagnostic.config({
        virtual_text = true,
        float = {
          border = border_style,
        },
      })
      vim.o.winborder = "rounded"

      require("lspconfig.ui.windows").default_options = {
        border = border_style,
      }

      vim.api.nvim_win_set_option(
        vim.api.nvim_get_current_win(), "winhighlight",
        "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None"
      )
    end
  }
}
