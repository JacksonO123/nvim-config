return {
    "sindrets/diffview.nvim",
    config = function()
        local actions = require("diffview.actions");
        local diffview = require("diffview");
        diffview.setup({
            keymaps = {
                view = {
                    { "n", "<leader>q", actions.close },
                    { "n", "<leader>e", actions.toggle_files }
                },
                file_panel = {
                    { "n", "<leader>e", actions.toggle_files },
                    { "n", "<leader>q", function()
                        -- close file panel
                        actions.close()
                        -- close diffview
                        actions.close()
                    end },
                }
            }
        })
    end
}
