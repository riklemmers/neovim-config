local M = {}

M.opts = function()
	local null_ls = require("null-ls")
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	local opts = {
		sources = {
			null_ls.builtins.formatting.gofumpt,
			null_ls.builtins.formatting.goimports_reviser,
			null_ls.builtins.formatting.golines.with({
				extra_args = { "-m", "160" },
			}),
			null_ls.builtins.diagnostics.golangci_lint.with({
				extra_args = { "-E", "bodyclose", "-E", "zerologlint", "-E", "errorlint", "-E", "exportloopref", "-E", "forcetypeassert", "-E", "gosec", "-E", "musttag", "-E", "predeclared", "-E", "sqlclosecheck", "-E", "unconvert", "-E", "usestdlibvars" },
			}),

			null_ls.builtins.formatting.stylua.with({
				extra_args = { "--collapse_simple_statement", "Never"},
			}),
			null_ls.builtins.formatting.prettier.with({
				extra_args = { "--tab-width", "2", "--print-width", "128" },
			}),
			null_ls.builtins.formatting.terraform_fmt,
			null_ls.builtins.diagnostics.pylint,
			null_ls.builtins.formatting.black,

			require("none-ls.code_actions.eslint"),
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr,
				})
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
	}
	return opts
end

M.ft = function()
	return { "go", "lua", "json", "terraform", "tf", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "jsonc", "yaml", "markdown", "markdown.mdx", "svelte", "python" }
end

M.sources = function()
	require("none-ls.code_actions.eslint");
end

return M
