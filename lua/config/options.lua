local settings = require("config.settings")
local opt = vim.opt;

opt.shiftwidth = settings.tab_width
opt.tabstop = settings.tab_width
opt.expandtab = true
opt.softtabstop = settings.tab_width

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

opt.winborder = "none"
opt.splitright = true;
