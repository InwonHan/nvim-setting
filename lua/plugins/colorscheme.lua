return {
  "drewtempelmeyer/palenight.vim",
  config = function()
    vim.cmd([[colorscheme palenight]])

    vim.api.nvim_set_hl(0, "@operator", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#FFCB6B" })
    vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })
    vim.api.nvim_set_hl(0, "@operator.assignment", { link = "Keyword" })
  end,
}