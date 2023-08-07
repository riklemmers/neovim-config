-- general
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

--vim.keymap.set("v", "J", "<cmd> m '>+1<CR>gv=gv'")
--vim.keymap.set("v", "K", "<cmd> m '>-2<CR>gv=gv'")

-- nvim-tree
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>")

vim.keymap.set("t", "<C-space>", "<C-\\><C-n>")
