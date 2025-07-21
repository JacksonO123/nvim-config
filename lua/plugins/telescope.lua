return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          hidden = true,
        }
      })

      telescope.load_extension("fzf")

      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
    end
  }
}
