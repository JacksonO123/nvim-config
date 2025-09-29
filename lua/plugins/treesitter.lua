return {
    { "JoosepAlviste/nvim-ts-context-commentstring", },
    {
        "nvim-treesitter/playground",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            local treesitter_configs = require("nvim-treesitter.configs")
            local context_commentstring = require("ts_context_commentstring")

            context_commentstring.setup()

            treesitter_configs.setup({
                modules = {},

                -- A list of parser names, or "all"
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "tsx",
                    "bash",
                    "c",
                    "css",
                    "go",
                    "html",
                    "make",
                    "json",
                    "python",
                    "regex",
                    "rust",
                    "sql",
                    "zig",
                    "lua"
                },

                -- List of parsers to ignore installing (for "all")
                ignore_install = {},

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                -- matchup = {
                --   enable = false, -- mandatory, false will disable the whole extension
                --   -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
                -- },
                highlight = {
                    enable = true, -- false will disable the whole extension
                    additional_vim_regex_highlighting = false,
                    -- disable = function(lang, buf)
                    --   if vim.tbl_contains({ "latex" }, lang) then
                    --     return true
                    --   end
                    --
                    --   local big_file_status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
                    --   return big_file_status_ok and big_file_detected
                    -- end,
                },
                indent = {
                    enable = true,
                    disable = { "yaml", "python" },
                },
                textobjects = {
                    swap = {
                        enable = false,
                    },
                    select = {
                        enable = false,
                    },
                },
                textsubjects = {
                    enable = false,
                },
            })

            local ts_utils = require("nvim-treesitter.ts_utils")
            ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
            ts_utils.get_node_range = vim.treesitter.get_node_range
        end
    },
}
