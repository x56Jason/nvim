return {
	{
		"folke/tokyonight.nvim",
		config = function() require("config.tokyonight") end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function() require("config.kanagawa") end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function() require("config.catppuccin") end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		config = function() require("config.lsp") end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = function() require("config.telescope") end,
	},

	{ "nvim-telescope/telescope-file-browser.nvim", },
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },

	{
		"kyazdani42/nvim-tree.lua",
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
		"simrat39/symbols-outline.nvim",
		config = function() require("config.symbols") end,
	},

	{
		"akinsho/nvim-toggleterm.lua",
		config = function() require("config.toggleterm") end,
	},

	{ "ironhouzi/starlite-nvim" },

	{
		"folke/which-key.nvim",
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
		config = function() require("config.colorizer") end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function() require("config.mini-indentscope") end,
	},
}
