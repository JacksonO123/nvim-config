# Nvim Config

I made + use this config

Expected to be used with most recent neovim + Lazy + Mason

## Configuration

### General Config Options

Some simple behavior and style settings are available in `lua/config/settings.lua` such as:

- `icons` (definitions found in `lua/defs/icons.lua`)
- `map_leader` and `map_local_leader`
- `format_on_save`
- `tab_width`
- `transparent`
- `transparentLuaLine`
- `colorscheme`
- `formatter_ft`
- `format_ops`
- `mason_lsp_clients`
- `bin_lsp_clients`
- `override_scroll_events`

#### Colorschemes

Colorschemes can be configured by providing the name of either a downloaded colorscheme, or vim colorscheme as a string in `lua/config/settings.lua`. The colorscheme can be defined to be downloaded in `lua/config/colorschemes.lua`.

#### Formatters

The formatter declerations found in `lua/config/settings.lua` are fed into `conform.nvim`. See their config [here](https://github.com/stevearc/conform.nvim).

#### Lsp clients

Lsp clients listed in `mason_lsp_clients` are fed into `mason-lspconfig` as `ensure_installed` entries.

Both `mason_lsp_clients` and `bin_lsp_clients` can be have their individual lsp configs in a `lua/lsp/<server name>.lua` config file. This will be found and passed to `vim.lsp.config(...)`

`bin_lsp_clients` exists to make sourcing lsp servers from local bin files easy. To get started, list the lsp name, then add the `lua/lsp/<server name>.lua` and specify the cmd to point to the local bin file.

#### Scroll events

For slower scrolling, enable `override_scroll_events`. Each scroll event will translate to a one line scroll up or down key bind.

### Keymaps

Keymap configuration can be found in `lua/config/keymaps.lua`.

Certain plugins may have keymap configurations in their file.

### Vim behavior

More direct vim behavior settings can be found in `lua/config/options.lua`.

### Misc

Plugin specific configuration can be found in `lua/plugins/{plugin_in_question}`.
