return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        -- Load Mason FIRST before setting up LSP servers
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "eslint_d",
                "prettier",
                "stylua",
                "isort",
                "black",
                "pylint",
                "csharpier",
            },
        })

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Set up Mason and LSP servers
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "html",
                "csharp_ls",
                "cssls",
                "tailwindcss",
                "dockerls",
                "graphql",
                "pyright",
                "sorbet",
                "sqlls",
            },
        })

        -- Diagnostic symbols in the sign column
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Setup handlers for each LSP server
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            ["graphql"] = function()
                -- configure graphql language server
                lspconfig["graphql"].setup({
                    capabilities = capabilities,
                    filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
                })
            end,
                
            ["emmet_ls"] = function()
                -- configure emmet language server
                lspconfig["emmet_ls"].setup({
                    capabilities = capabilities,
                    filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
                })
            end,

            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                        globals = { "vim" },
                        },
                        completion = {
                        callSnippet = "Replace",
                        },
                    },
                    },
                })
            end,

            ["csharp_ls"] = function()
                lspconfig["csharp_ls"].setup({
                    capabilities = capabilities,
                })
            end,

            ["eslint"] = function()
                lspconfig["eslint"].setup({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                })
            end,
        })

        -- Keybinds for LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                local keymap = vim.keymap

                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })
    end,
}