return {
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()

            local registry = require("mason-registry")
            registry.refresh(function()
                for _, name in ipairs(require("config.settings").mason_tools) do
                    local pkg = registry.get_package(name)
                    if not pkg:is_installed() and not pkg:is_installing() then
                        pkg:install()
                    end
                end
            end)
        end,
    },
}
