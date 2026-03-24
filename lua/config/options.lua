local settings = require("config.settings")
local opt = vim.opt

opt.shiftwidth = settings.tab_width
opt.tabstop = settings.tab_width
opt.expandtab = true
opt.softtabstop = settings.tab_width

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
	end,
})

opt.scrolloff = 3
opt.sidescroll = 3

opt.relativenumber = true
opt.number = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"

opt.updatetime = 400
opt.timeoutlen = 450

opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = false
opt.cursorline = false

opt.autoindent = true
opt.smartindent = true
opt.wrap = false

opt.swapfile = false

opt.winborder = "rounded"
opt.splitright = true

vim.o.winborder = "rounded"
