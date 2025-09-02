-- Capabilities passed to every lsp
vim.lsp.config('*', {
    capabilities = {},
})

-- enabled lsp servers (from /lsp configs)
vim.lsp.enable({
    'vtsls',
    'lua-ls',
    'css-ls',
    'html-ls',
    'tailwindcss',
    'intelephense',
    'vue-ls',
})

-- Global diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    float = {
        source = "always",
        border = "rounded",
    },
    jump = { float = true },
})
