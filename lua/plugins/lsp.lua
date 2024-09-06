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
	vim.keymap.set("n", "rr", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set("n", "<leader>f", function() vim.diagnostic.open_float() end, opts)
end

local border = {
	{"╭", "FloatBorder"},
	{"─", "FloatBorder"},
	{"╮", "FloatBorder"},
	{"│", "FloatBorder"},
	{"╯", "FloatBorder"},
	{"─", "FloatBorder"},
	{"╰", "FloatBorder"},
	{"│", "FloatBorder"},
}

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border })

-- Specific LSP setup

lspconfig.gopls.setup({
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			gofumpt = true,
			completeUnimported = true,
			usePlaceholders = true,
			staticcheck = true,
			semanticTokens = true,
			analyses = {
				fieldalignment = true,
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
				shadow = true,
				timeformat = true,
			},
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = false, -- legacy
				tidy = true,
				upgrade_dependency = true,
				vendor = true
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
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

lspconfig.bicep.setup({
	filetypes = { "bicep" },
	cmd = { "/Users/rik/.local/share/nvim/mason/bin/bicep-lsp" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Apply a default config to other LSPs
local servers = { 'lua_ls', 'jsonls', 'ts_ls', 'eslint', 'html', 'cssls', 'svelte', 'pyright', 'lemminx' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		capabilities = capabilities,
		on_attach = on_attach,
	}
end

