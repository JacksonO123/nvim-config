local M = {}

local root_markers = { ".git", "package.json" }

local function get_search_bounds(bufnr)
    local path = vim.api.nvim_buf_get_name(bufnr or 0)
    if path == "" then
        return nil
    end

    local dir = vim.fs.dirname(vim.fs.abspath(path))
    return dir, vim.fs.root(dir, root_markers) or dir
end

function M.find_config(bufnr, files)
    local dir, root = get_search_bounds(bufnr)
    if not dir then
        return nil
    end

    return vim.fs.find(files, {
        upward = true,
        path = dir,
        stop = vim.fs.dirname(root),
        limit = 1,
    })[1]
end

function M.find_node_bin(dir, name)
    local root = vim.fs.root(dir, root_markers) or dir

    for parent in vim.fs.parents(vim.fs.joinpath(dir, name)) do
        local bin = vim.fs.joinpath(parent, "node_modules", ".bin", name)
        if vim.uv.fs_stat(bin) then
            return bin
        end
        if parent == root then
            break
        end
    end

    return nil
end

function M.get_js_formatter(bufnr)
    local prettier_files = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.toml",
        ".prettierrc.js",
        "prettier.config.js",
        "prettier.config.mjs",
        "prettier.config.cjs",
        "prettier.config.ts",
        ".prettierrc.mjs",
        ".prettierrc.cjs",
        ".prettierrc.ts",
        ".prettierrc.json5",
    }

    local oxfmt_files = {
        ".oxfmtrc.json",
        ".oxfmtrc.jsonc",
        "oxfmt.config.ts",
    }

    if M.find_config(bufnr, prettier_files) then
        return { "prettier" }
    end

    if M.find_config(bufnr, oxfmt_files) then
        return { "oxfmt" }
    end

    return { lsp_format = "never" }
end

function M.get_js_linter(bufnr)
    local oxlint_files = {
        ".oxlintrc.json",
        "oxlint.config.ts",
    }

    local eslint_files = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yml",
        ".eslintrc.yaml",
    }

    local oxlint_config = M.find_config(bufnr, oxlint_files)
    if oxlint_config then
        return { "oxlint" }, vim.fs.dirname(oxlint_config)
    end

    local eslint_config = M.find_config(bufnr, eslint_files)
    if eslint_config then
        return { "eslint" }, vim.fs.dirname(eslint_config)
    end

    return {}
end

return M
