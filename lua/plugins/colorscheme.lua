return {
  "sho-87/kanagawa-paper.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa-paper").setup({
      transparent = true
    })
    vim.opt.termguicolors = true
    vim.cmd([[colorscheme kanagawa-paper]])
  end,
  --[[opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },]]--
}
