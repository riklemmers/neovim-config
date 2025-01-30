local opt = vim.opt
local g = vim.g

--- options ---
opt.number = true
--opt.numberwidth = 2
--opt.ruler = false
opt.relativenumber = true
opt.signcolumn = "yes"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.scrolloff = 8

g.mapleader = " "

-- nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
opt.termguicolors = true

-- indent-blankline
opt.list = true
opt.listchars:append("space:⋅")

-- compare
opt.diffopt = opt.diffopt + "iwhite"

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("core.mappings")
