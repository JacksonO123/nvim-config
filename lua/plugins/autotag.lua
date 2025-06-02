return {
  "windwp/nvim-ts-autotag",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("nvim-ts-autotag").setup()
  end
}
