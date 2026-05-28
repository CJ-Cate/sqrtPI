-- require("paq")
require("remap")
require("options")

--vim.cmd("colorscheme matugen")
vim.api.nvim_create_autocmd("Signal", {
    pattern = "SIGUSR1",
    command = "colorscheme matugen",
})

require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself
--    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
}

-- require'nvim-treesitter'.install { 'css', 'cpp', 'c', 'python', 'bash' }
