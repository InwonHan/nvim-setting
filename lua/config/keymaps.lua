local mapKey = require("utils.keyMapper").mapKey

-- Neotree toggle
mapKey("<leader>e", ":Neotree toggle<cr>")

-- pane navigation
mapKey("<C-h>", "<C-w>h") -- Left
mapKey("<C-j>", "<C-w>j") -- Down
mapKey("<C-k>", "<C-w>k") -- Up
mapKey("<C-l>", "<C-w>l") -- Right

-- clear search hl
mapKey("<leader>h", ":nohlsearch<CR>")

-- diagnostic flaot
mapKey("<leader>i", ":lua vim.diagnostic.open_float()<CR>")

-- indent
mapKey("<", "<gv", "v")
mapKey(">", ">gv", "v")

-- floaterm
mapKey("<C-;>", ":FloatermToggle<CR>")

-- Exit insert mode with jk
mapKey("jk", "<ESC>")

-- increment/decrement numbers
mapKey("<leader>+", "<C-a>") -- increment
mapKey("<leader>-", "<C-x>") -- decrement

-- window management
mapKey("<leader>sv", "<C-w>v") -- split window vertically
mapKey("<leader>sh", "<C-w>s") -- split window horizontally
mapKey("<leader>se", "<C-w>=") -- make split windows equal width & height
mapKey("<leader>sx", "<cmd>close<CR>") -- close current split window

mapKey("<leader>to", "<cmd>tabnew<CR>") -- open new tab
mapKey("<leader>tx", "<cmd>tabclose<CR>") -- close current tab
mapKey("<leader>tn", "<cmd>tabn<CR>") --  go to next tab
mapKey("<leader>tp", "<cmd>tabp<CR>") --  go to previous tab
mapKey("<leader>tf", "<cmd>tabnew %<CR>") --  move current buffer to new tab

mapKey("<leader>dt", ":DapUiToggle<CR>", {noremap=true})
mapKey("<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
mapKey("<leader>dc", ":DapContinue<CR>", {noremap=true})
mapKey("<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})