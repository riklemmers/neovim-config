local M = {}

M.opts = function(opts)
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	opts.snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
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

	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local mappings = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}
	opts.mapping = cmp.mapping.preset.insert(mappings)

	vim.api.nvim_create_autocmd('ModeChanged', {
		pattern = '*',
		callback = function()
			if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
				and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require('luasnip').session.jump_active
			then
			  require('luasnip').unlink_current()
			end
		end
	})

	return opts
end

return M
