return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		config = function() require("config.tokyonight") end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		config = function() require("config.kanagawa") end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		config = function() require("config.catppuccin") end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		config = function() require("config.lsp") end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
		},
		config = function() require("config.telescope") end,
	},

	{
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		keys = {
			{ "tt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		},
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function() require("config.nvim-tree") end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function() require("config.lualine") end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function() require("config.treesitter") end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "onsails/lspkind-nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function() require("config.cmp") end,
	},

	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "ts", "<cmd>Outline<CR>", desc = "Toggle Symbol Outline" },
		},
		opts = {
			symbols = { icon_source = lspkind, },
		}
	},

	{
		"akinsho/nvim-toggleterm.lua",
		cmd = { "ToggleTerm" },
		keys = {
			{ "<C-n>", "<cmd>ToggleTerm<CR>", desc = "Toggle Term" },
		},
		opts = {
			direction = "float",
		},
	},

	{ "ironhouzi/starlite-nvim" },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("config.which") end,
	},

	{
		"yorickpeterse/nvim-window",
		config = function() require("config.nvim-window") end,
 	},

	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-fugitive" },

	{
		"natecraddock/workspaces.nvim",
		config = function() require("config.workspaces") end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		opts = { user_default_options = {mode = "foreground",}, },
	},

	{ "nmac427/guess-indent.nvim", },

	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function() require("config.mini-indentscope") end,
	},

}
