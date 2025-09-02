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
        -- Load Mason FIRST
        require("mason").setup()
        
        -- Load mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        
        -- Set up Mason LSP config with servers to install
        mason_lspconfig.setup({
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
        
        -- Set up mason tool installer
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

        -- Diagnostic symbols in the sign column
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Manual LSP server setup (alternative to setup_handlers)
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            html = {},
            csharp_ls = {},
            cssls = {},
            tailwindcss = {},
            dockerls = {},
            graphql = {
                filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
            },
            pyright = {},
            sorbet = {},
            sqlls = {},
            emmet_ls = {
                filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
            },
            eslint = {
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            },
        }

        -- Set up each server
        for server_name, server_config in pairs(servers) do
            local config = vim.tbl_deep_extend("force", {
                capabilities = capabilities,
            }, server_config)
            
            lspconfig[server_name].setup(config)
        end

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