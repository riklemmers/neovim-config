local M = {}
M.integrations = {
	cmp = true,
	gitsigns = true,
	nvimtree = true,
	treesitter = true,
	indent_blankline = {
		enabled = true,
		colored_indent_levels = false,
	},
	mason = true,
	telescope = {
		enabled = true,
	},
	native_lsp = {
		enabled = true,
		virtual_text = {
			errors = { "italic" },
			hints = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
		},
		underlines = {
			errors = { "underline" },
			hints = { "underline" },
			warnings = { "underline" },
			information = { "underline" },
		},
		inlay_hints = {
			background = true,
		},
	},
}
-- M.color_overrides = {
-- 	latte = {
-- 		base = "#f9f9f9",
-- 	},
-- }
return M
