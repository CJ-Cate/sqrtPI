-- require("paq")
require("remap")
require("options")

require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
}

require'nvim-treesitter'.install { 'css', 'cpp', 'c', 'python', 'bash' }
