# Nvim Config

I made + use this config

Expected to be used with most recent neovim + Lazy + Mason

## Configuration

### Keymaps

Keymap configuration can be found in `lua/config/keymaps.lua`.

Certain plugins may have keymap configurations in their file.

### Vim behavior

More direct vim behavior settings can be found in `lua/config/options.lua`.

### Colorschemes

Colorschemes can be configured by providing the name of a downloaded colorscheme as a string in `lua/config/settings.lua`. The colorscheme can be defined to be downloaded in `lua/config/colorschemes.lua`.

### General

Some simple behavior and style settings are available in `lua/config/settings.lua` such as:

- `icons` (definitions found in `lua/defs/icons.lua`)
- `map_leader` and `map_local_leader`
- `format_on_save`
- `tab_width`
- `transparent`
- `colorscheme`
- `formatter_ft` (See later)
- `format_ops`
- `lsp_clients` (See later)

### Formatters

The formatter definitions are fed into `conform.nvim`. See their config [here](https://github.com/stevearc/conform.nvim).

### Lsp clients

Lsp clients are fed into `mason-lspconfig` as `ensure_installed` entries. They are also passed into `vim.lsp.enable(...)`.

### Misc

Plugin specific configuration can be found in `lua/plugins/{plugin_in_question}`.
