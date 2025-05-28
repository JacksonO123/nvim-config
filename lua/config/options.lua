vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

vim.opt.scrolloff = 3
vim.opt.sidescroll = 3

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 400
vim.opt.timeoutlen = 450

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.cursorline = false
vim.opt.clipboard = "unnamedplus"

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "highlight link typescriptVariable Keyword"
})

-- vim.cmd("highlight link typescriptVariable Keyword")
