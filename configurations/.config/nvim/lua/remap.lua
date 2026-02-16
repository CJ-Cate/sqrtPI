-- Set leader key, which is <leader>, to space
vim.g.mapleader = " "

-- quick return to file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- highlight to move things
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Keep cursor at the start of line when using big J
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in the middle when doing stuff
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- highlight to replace and maintain buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- user leader y to take things to your system clipboard
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- -- vim.keymap.set("Y", "<leader>Y", "\"+Y") -- I dont know what 'Y' is but its included here anyways
vim.opt.clipboard = "unnamedplus"

-- Remote big Q, learn from those who walked the path
vim.keymap.set('n', 'Q', '<nop>')

-- Disable arrow keys
vim.keymap.set({'n', 'i', 'v'}, '<Up>', '<nop>')
vim.keymap.set({'n', 'i', 'v'}, '<Down>', '<nop>')
vim.keymap.set({'n', 'i', 'v'}, '<Left>', '<nop>')
vim.keymap.set({'n', 'i', 'v'}, '<Right>', '<nop>')
