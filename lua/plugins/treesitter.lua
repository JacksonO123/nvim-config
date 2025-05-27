return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local ts_status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not ts_status_ok then
      return
    end

    local status_ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
    if not status_ok then
      return
    end

    ts_context_commentstring.setup({
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = "// %s",
        css = "/* %s */",
        scss = "/* %s */",
        html = "<!-- %s -->",
        svelte = "<!-- %s -->",
        vue = "<!-- %s -->",
        json = "",
      },
    })

    treesitter_configs.setup({
      modules = {},

      -- A list of parser names, or "all"
      ensure_installed = {},

      -- List of parsers to ignore installing (for "all")
      ignore_install = {},

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      matchup = {
        enable = false, -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          if vim.tbl_contains({ "latex" }, lang) then
            return true
          end

          local big_file_status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
          return big_file_status_ok and big_file_detected
        end,
      },
      indent = { enable = true, disable = { "yaml", "python" } },
      autotag = { enable = false },
      textobjects = {
        swap = {
          enable = false,
          -- swap_next = textobj_swap_keymaps,
        },
        -- move = textobj_move_keymaps,
        select = {
          enable = false,
          -- keymaps = textobj_sel_keymaps,
        },
      },
      textsubjects = {
        enable = false,
        keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
      },
      playground = {
        enable = false,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      rainbow = {
        enable = false,
        extended_mode = true,  -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      },
    })

    local ts_utils = require("nvim-treesitter.ts_utils")
    ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
    ts_utils.get_node_range = vim.treesitter.get_node_range
  end
}
