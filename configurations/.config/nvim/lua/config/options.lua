-- leader key
vim.g.mapleader = " "

-- Line numbers
vim.opt.nu = true -- nu = number, apparently
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Stop wrapping
vim.opt.wrap = false

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Buffer of 8 lines top and bottom
vim.opt.scrolloff = 8
-- Add some extra space on the far left
vim.opt.signcolumn = "yes"
-- Inactivity time for events to fire in ms. Default is 4000
vim.g.updatetime = 250
-- Column to keep things readable everywhere
vim.opt.colorcolumn = "120"
