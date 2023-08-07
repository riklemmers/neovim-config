local plugins = {

	-- Modules
	{ "nvim-lua/plenary.nvim" },

	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin-latte]])
		end,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "lua_ls", "gopls" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
			},
			{
				-- cmp sources plugins
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
			},
		},
		opts = function(_, opts)
			return require("plugins.configs.nvim-cmp").opts(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function(_, opts)
			local configs = require("nvim-treesitter.configs")
			configs.setup(opts)
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = { "go", "lua" },
		opts = function()
			return require("plugins.configs.null-ls")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			return require("plugins.configs.nvim-tree")
		end,
	},

	-- Code editing
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
		},
	},
	{
		-- indenting tab/space detection
		"tpope/vim-sleuth",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			local c = require("Comment")
			c.setup()
		end,
	},
	
	-- GIT
	{
		"tpope/vim-fugitive"
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()
		end,
	},
}

require("lazy").setup(plugins, opts)

require("plugins.lsp")
