local plugins = {

	{ "nvim-lua/plenary.nvim" },

	-- Theme
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function(_, opts)
	-- 		require("tokyonight").setup(opts)
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = function()
			return require("plugins.configs.catppuccin-opts")
		end,
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "lua_ls", "gopls", "terraformls", "jsonls", "tsserver", "eslint", "html", "cssls", "svelte" },
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
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				dependencies = "rafamadriz/friendly-snippets",
			},
			{
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
		"nvimtools/none-ls.nvim",
		ft = function()
			return require("plugins.configs.null-ls").ft()
		end,
		cmd = { "NullLsInfo", "NullLsLog" },
		opts = function()
			return require("plugins.configs.null-ls").opts()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>tt", function() require("trouble").toggle() end },
			{ "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end },
			{ "<leader>td", function() require("trouble").toggle("document_diagnostics") end },
			{ "<leader>tn", function() require("trouble").next({skip_groups = true, jump = true}) end },
			{ "<leader>tp", function() require("trouble").previous({skip_groups = true, jump = true}) end },
		}
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
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		},
		keys = {
			{ "<leader>ff", function() require("telescope.builtin").find_files() end },
			{ "<leader>fg", function() require("telescope.builtin").live_grep() end },
			{ "<leader>fsg", function() require("telescope.builtin").grep_string() end },
			{ "<leader>fb", function() require("telescope.builtin").buffers() end },
			{ "<leader>fh", function() require("telescope.builtin").help_tags() end },
			{ "<leader>fr", function() require("telescope.builtin").lsp_references() end },
			{ "<leader>fva", function() require("telescope.builtin").git_commits() end },
			{ "<leader>fvc", function() require("telescope.builtin").git_bcommits() end },
			{ "<leader>fvb", function() require("telescope.builtin").git_branches() end },
			{ "<leader>fvs", function() require("telescope.builtin").git_status() end },
			{ "<leader>ca", function() vim.lsp.buf.code_action() end },
		},
		opts = function()
			return {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_cursor {
						}
					}
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
		end,
	},

	-- Code editing
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	tag = "v2.20.8",
	-- 	opts = {
	-- 		space_char_blankline = " ",
	-- 		show_current_context = true,
	-- 		show_current_context_start = true,
	-- 	},
	-- },
	{
		"nmac427/guess-indent.nvim",
		config = function(_, opts)
			require('guess-indent').setup(opts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		cmd = { "GoInstallDeps" },
		build = function()
			vim.cmd [[silent! GoInstallDeps]]
		end,
		keys = {
			{ "<leader>gtj", "<cmd> GoTagAdd json <CR>" },
			{ "<leader>gty", "<cmd> GoTagAdd yaml <CR>" },
			{ "<leader>grj", "<cmd> GoTagRm json <CR>" },
			{ "<leader>gry", "<cmd> GoTagRm yaml <CR>" },
			{ "<leader>ge", "<cmd> GoIfErr <CR>" },
		},
	},

	-- GIT
	{
		"tpope/vim-fugitive"
	},
	{
		"cedarbaum/fugitive-azure-devops.vim",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
	},
}

require("lazy").setup(plugins, opts)

require("plugins.lsp")
