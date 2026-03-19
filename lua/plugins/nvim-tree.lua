return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFocus" },
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function(data)
                    if vim.fn.isdirectory(data.file) == 1 then
                        vim.cmd.cd(data.file)
                        require("nvim-tree.api").tree.open()
                    end
                end,
            })
        end,
        config = function()
            local api = require("nvim-tree.api")

            local function custom_attach(bufnr)
                local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set("n", "l", api.node.open.edit, opts)
                vim.keymap.set("n", "h", api.node.open.edit, opts)
                vim.keymap.set("n", "v", api.node.open.vertical, opts)
            end

            require("nvim-tree").setup({
                on_attach = custom_attach,
                hijack_cursor = true,
                filters = {
                    dotfiles = false,
                    git_ignored = false,
                },
                view = {
                    preserve_window_proportions = true,
                    width = 40
                },
                update_focused_file = {
                    enable = true,
                    update_root = {
                        enable = true,
                    },
                },
                sync_root_with_cwd = true,
                renderer = {
                    highlight_git = "name",
                    highlight_hidden = "all",
                    icons = {
                        show = {
                            git = false,
                        },
                    },
                },
                filesystem_watchers = {
                    ignore_dirs = {
                        "node_modules",
                        ".git",
                        "build",
                        "target",
                        "zig-out",
                        ".next",
                    },
                }
            })
        end
    }
}
