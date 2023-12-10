return {
	{'folke/lazy.nvim'},

	{'folke/tokyonight.nvim'},
	{'rebelot/kanagawa.nvim'},
	{ "catppuccin/nvim", name = "catppuccin", },

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	},

	{ "nvim-telescope/telescope-file-browser.nvim" },

	{
		'kyazdani42/nvim-tree.lua',
		dependencies = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		}
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
	},

	{ "simrat39/symbols-outline.nvim", },

	{ "akinsho/nvim-toggleterm.lua", },

	"ironhouzi/starlite-nvim",

	{ "folke/which-key.nvim" },

	{ "https://github.com/yorickpeterse/nvim-window.git" },

	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-fugitive" },
	{ "natecraddock/workspaces.nvim" },

	{ "NvChad/nvim-colorizer.lua" },

	{
		"mycolorscheme",
		dir = "~/.config/nvim/lua/mycolorscheme"
	},
}
