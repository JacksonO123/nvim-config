return {
  "thesimonho/kanagawa-paper.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa-paper").setup({
      transparent = true,
      colors = {
        palette = {
          sumiInk6 = '#828282',
        }
      },
    })
    vim.opt.termguicolors = true
    vim.cmd.colorscheme("kanagawa-paper")
  end,
}
