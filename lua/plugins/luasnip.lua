return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local luasnip = require("luasnip")

        luasnip.config.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" },
        })

        vim.keymap.set({ "i", "s" }, "<C-l>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { desc = "Expand snippet or jump to next placeholder" })

        vim.keymap.set({ "i", "s" }, "<C-h>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { desc = "Jump to previous snippet placeholder" })

        vim.keymap.set({ "i", "s" }, "<C-u>", function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { desc = "Cycle snippet choice" })
    end,
}
