return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'neovim/nvim-lspconfig', -- This should be loaded after your main LSP config
  },
  config = function()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    
    -- Set up folding capabilities for LSP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    
    -- Don't set up LSP servers here - let your main lsp.lua handle that
    -- Just configure ufo
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'lsp', 'indent'}
      end
    })
  end,
}