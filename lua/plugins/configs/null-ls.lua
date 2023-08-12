local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
	sources = {
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines.with({
			extra_args = { "-m", "128" },
		}),

		null_ls.builtins.formatting.stylua.with({
			extra_args = { "--collapse_simple_statement", "Never"},
		}),
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.formatting.prettier.with({
			extra_args = { "--tab-width", "4" },
		}),
		null_ls.builtins.formatting.terraform_fmt,
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
