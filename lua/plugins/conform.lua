return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local formatter_utils = require("utils.formatter")
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "styleua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        html = { "htmlbeautifier" },
        bash = { "beautysh" },
        rust = { "rustfmt" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
        css = { "prettierd" },
        scss = { "prettierd" },
      }
    })

    local format_augroup = vim.api.nvim_create_augroup("format", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = format_augroup,
      callback = function()
        conform.format(formatter_utils.format_ops)
      end
    })
  end
}
