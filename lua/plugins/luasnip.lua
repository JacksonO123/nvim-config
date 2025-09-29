return {
    {
        "rafamadriz/friendly-snippets",
        lazy = true,
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
    }
}
