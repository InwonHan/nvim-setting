return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "lua", "javascript", "html", "markdown", "typescript", "tsx", "json", "c_sharp", "css", "dart", "python", "ruby", "sql" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
