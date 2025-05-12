return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local api = require("nvim-tree.api")

    local function custom_attach(bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set("n", "l", api.node.open.edit, opts)
      vim.keymap.set("n", "h", api.node.open.edit, opts)
      vim.keymap.set("n", "v", api.node.open.vertical, opts)
    end

    require("nvim-tree").setup({
      on_attach = custom_attach,
      hijack_cursor = true,
      view = {
        preserve_window_proportions = true,
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
        },
      },
      sync_root_with_cwd = true,
      renderer = {
        highlight_git = "name",
        icons = {
          show = {
            git = false,
          },
        },
      },
    })
  end
}
