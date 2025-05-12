return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    local icons = require("config.icons")

    require("ibl").setup({
      enabled = true,
      exclude = {
        buftypes = { "terminal", "nofile" },
        filetypes = {
          "help",
          "startify",
          "dashboard",
          "lazy",
          "neogitstatus",
          "NvimTree",
          "Trouble",
          "text",
        },
      },
      indent = {
        char = icons.ui.LineLeft,
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    })
  end
}
