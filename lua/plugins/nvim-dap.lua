return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",         -- UI for nvim-dap
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text", -- Virtual text for debugging
        "nvim-telescope/telescope-dap.nvim", -- Telescope integration
        "mfussenegger/nvim-dap-python", -- Python debugging
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- 🔹 Configure UI
        dapui.setup()

        -- Auto open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        dap.adapters.node2 = {
            type = "executable",
            command = "node",
            args = { os.getenv("HOME") .. "/.config/nvim/vscode-js-debug/out/src/debugServerMain.js", "--stdio" },
        }
        
        dap.configurations.javascript = {
            {
                type = "node2",
                request = "launch",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                console = "integratedTerminal",
            },
        }
        dap.configurations.typescript = dap.configurations.javascript -- ✅ Use same config for TypeScript

        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
        }
        
        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    return "/usr/bin/python3" -- Change this if needed
                end,
            },
        }

        -- 🔹 Keybindings
        vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>ds", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>do", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

        -- 🔹 Virtual Text (shows debug info inline)
        require("nvim-dap-virtual-text").setup()

        -- 🔹 Telescope DAP integration
        require("telescope").load_extension("dap")
    end,
}