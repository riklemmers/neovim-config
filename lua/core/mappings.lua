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

-- Fix :GBrowse for vim-fugitive because netrw is disabled.
vim.api.nvim_create_user_command('Browse', function(opts)
    local cmd = string.format("!open %s",
        vim.fn.shellescape(opts.args, 1)
    )
    vim.fn.execute(cmd)
end,
{ nargs = 1 }
)
