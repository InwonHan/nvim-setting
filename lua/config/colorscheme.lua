local M = {}

function M.setup()
  local colors = {
    background       = "#292D3E", -- dark purple/gray
    foreground       = "#BFC7D5", -- light gray
    mint             = "#C3E88D", -- greenish (strings)
    orange           = "#F78C6C", -- orange (numbers)
    purple           = "#C792EA", -- purple (keywords)
    lightblue        = "#82AAFF", -- bright blue (functions)
    gold             = "#FFCB6B", -- gold (variables)
    cyan             = "#89DDFF", -- cyan (operators)
    comment          = "#697098", -- grayish (comments)
    red              = "#EF5350", -- red (errors)
    yellow           = "#FFCA28", -- yellow (warnings)
    line_fg          = "#4C5374", -- line number (inactive)
    line_fg_active   = "#EEFFFF", -- line number (active)
    selection        = "#7580B8", -- visual selection
    statusline_fg    = "#FFFFFF", -- (you can change to "#676E95" if desired)
    statusline_bg    = "#282C3D",
    vertsplit        = "#282B3C",
    pmenu_bg         = "#31364A",
    pmenu_fg         = "#BFC7D5",
    pmenu_sel_bg     = "#7E57C2",
    pmenu_sel_fg     = "#FFFFFF",
    incsearch_bg     = "#FFCB6B",
    incsearch_fg     = "#292D3E",
    matchparen_bg    = "#292D3E",
    matchparen_fg    = "#FFCB6B",
    cursorline_bg    = "#2E3245",
  }

  -- Editor “Normal” text
  vim.api.nvim_set_hl(0, "Normal",      { fg = colors.foreground, bg = colors.background })

  -- Basic syntax groups
  vim.api.nvim_set_hl(0, "Comment",     { fg = colors.comment, italic = true })
  vim.api.nvim_set_hl(0, "String",      { fg = colors.mint })
  vim.api.nvim_set_hl(0, "Number",      { fg = colors.orange })
  vim.api.nvim_set_hl(0, "Keyword",     { fg = colors.purple })
  vim.api.nvim_set_hl(0, "Function",    { fg = colors.lightblue })
  vim.api.nvim_set_hl(0, "Variable",    { fg = colors.gold })
  vim.api.nvim_set_hl(0, "Type",        { fg = colors.foreground })
  vim.api.nvim_set_hl(0, "Constant",    { fg = colors.lightblue })
  vim.api.nvim_set_hl(0, "Operator",    { fg = colors.cyan })
  vim.api.nvim_set_hl(0, "Delimiter",   { fg = colors.gold })
  vim.api.nvim_set_hl(0, "Punctuation", { fg = colors.gold })
  vim.api.nvim_set_hl(0, "Identifier",  { fg = colors.foreground })
  vim.api.nvim_set_hl(0, "Statement",   { fg = colors.purple })
  vim.api.nvim_set_hl(0, "PreProc",     { fg = colors.gold })
  vim.api.nvim_set_hl(0, "Special",     { fg = colors.lightblue })
  vim.api.nvim_set_hl(0, "Error",       { fg = colors.red })
  vim.api.nvim_set_hl(0, "Warning",     { fg = colors.yellow })

  -- UI Elements
  vim.api.nvim_set_hl(0, "CursorLine",      { bg = colors.cursorline_bg })
  vim.api.nvim_set_hl(0, "CursorLineNr",    { fg = colors.line_fg_active })
  vim.api.nvim_set_hl(0, "LineNr",          { fg = colors.line_fg })
  vim.api.nvim_set_hl(0, "Visual",          { bg = colors.selection })
  vim.api.nvim_set_hl(0, "StatusLine",      { fg = colors.statusline_fg, bg = colors.statusline_bg })
  vim.api.nvim_set_hl(0, "StatusLineNC",    { fg = "#676E95", bg = "#292D3E" })
  vim.api.nvim_set_hl(0, "VertSplit",       { fg = colors.vertsplit })
  vim.api.nvim_set_hl(0, "Pmenu",           { fg = colors.pmenu_fg, bg = colors.pmenu_bg })
  vim.api.nvim_set_hl(0, "PmenuSel",        { fg = colors.pmenu_sel_fg, bg = colors.pmenu_sel_bg })
  vim.api.nvim_set_hl(0, "IncSearch",       { fg = colors.incsearch_fg, bg = colors.incsearch_bg })
  vim.api.nvim_set_hl(0, "Search",          { fg = colors.incsearch_fg, bg = colors.incsearch_bg })
  vim.api.nvim_set_hl(0, "MatchParen",      { fg = colors.matchparen_fg, bg = colors.matchparen_bg, bold = true })
end

return M