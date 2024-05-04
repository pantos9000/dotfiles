if vim.g.vscode ~= nil then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()
