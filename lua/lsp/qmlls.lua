local M = {}

M.cmd = { "qmlls6", "-E" }
M.cmd_env = { QML_IMPORT_PATH = "/usr/lib/qt6/qml" }
M.filetypes = { "qml", "qmljs" }
M.root_markers = { ".qmlls.ini", "shell.qml", ".git" }
function M.on_attach(client, _)
    client.server_capabilities.semanticTokensProvider = nil
end

return M
