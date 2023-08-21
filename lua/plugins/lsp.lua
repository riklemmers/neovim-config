local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set("n", "<leader>f", function() vim.diagnostic.open_float() end, opts)
end

-- Specific LSP setup

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.terraformls.setup({
	filetypes = { "terraform" }, -- disable terraform-vars because of bug
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.svelte.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
