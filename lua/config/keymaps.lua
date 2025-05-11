-- some mappings may be in the configs for
-- individual packages just because

local opts = {
  noremap = true,
  silent = true,
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_pending_mode = "o",
}

local keymaps = {
  insert_mode = {
    ["<C-v>"] = "<esc>p",
  },

  normal_mode = {
    ["<leader>e"] = ":NvimTreeToggle<CR>",
    ["<leader>q"] = "<C-w>q",
    ["<leader>w"] = ":w<CR>",
    ["<leader>r"] = "grn",
    ["<leader>h"] = "<C-w>v",
    ["<leader>j"] = "<C-w>s",

    ["<leader>lj"] = vim.diagnostic.goto_next,
    ["<leader>lk"] = vim.diagnostic.goto_prev,

    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    ["gd"] = "<C-]>",
    ["gr"] = ":Telescope lsp_references<CR>",

    ["<leader>f"] = ":Telescope find_files<CR>",
    ["<leader>s"] = ":Telescope live_grep<CR>",

    ["<C-v>"] = "p",

     ["<leader>/"] = function()
       vim.cmd.norm('gcc')
     end
  },

  visual_mode = {
    ["<"] = "<gv",
    [">"] = ">gv",
  },

  visual_block_mode = {
     ["<leader>/"] = function()
       vim.cmd.norm('gc')
     end
  },
}

local function load_mode(mode, mappings)
  local map_mode = mode_adapters[mode]
  for k, v in pairs(mappings) do
    vim.keymap.set(map_mode, k, v, opts)
  end
end

local function load_maps()
  for mode, mappings in pairs(keymaps) do
    load_mode(mode, mappings)
  end
end

load_maps()
