local M = {}

M.opts = function(opts)
	local cmp = require("cmp")
	opts.snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	}
	opts.window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
	opts.sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	})

	local mappings = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
	}
	opts.mapping = cmp.mapping.preset.insert(mappings)

	return opts
end

return M
