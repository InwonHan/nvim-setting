return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

    -- Use mason-lspconfig to get the list of installed servers
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup()

    mason_lspconfig.setup_handlers({
      function(server_name) -- Default handler (for all servers)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities
          -- Add server-specific configurations here if needed
        })
      end,
    })

    require('ufo').setup()
  end,
}