-- require("akorchevsky")
require("just4n4cc")

-- Default config
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
		multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

-- vim.lsp.enable('luals')
-- vim.lsp.enable('clangd')

