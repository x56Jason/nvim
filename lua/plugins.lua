return {
	-- LSP (clangd) — replaces cscope/ctags
	{
		"neovim/nvim-lspconfig",
		cmd = "Mason",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function() require("config.lsp") end,
	},

	-- Telescope — replaces cscope find/grep
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function() require("config.telescope") end,
	},

	-- Call hierarchy — replaces cscope caller/callee
	{
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		keys = {
			{ "<leader>si", "<cmd>Telescope hierarchy incoming_calls<cr>", desc = "Incoming Calls" },
			{ "<leader>so", "<cmd>Telescope hierarchy outgoing_calls<cr>", desc = "Outgoing Calls" },
		},
		config = function()
			require("telescope").load_extension("hierarchy")
		end,
	},

	-- Treesitter — syntax highlight only
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function() require("config.treesitter") end,
	},

	-- Completion — manual trigger only
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
		},
		config = function() require("config.cmp") end,
	},

	-- Buffer switching
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		keys = {
			{ "m", desc = "Harpoon add file" },
			{ "MM", desc = "Harpoon menu" },
			{ "M1", desc = "Harpoon 1" },
			{ "M2", desc = "Harpoon 2" },
			{ "M3", desc = "Harpoon 3" },
			{ "M4", desc = "Harpoon 4" },
			{ "M5", desc = "Harpoon 5" },
			{ "<TAB>", desc = "Next buffer" },
			{ "<S-TAB>", desc = "Prev buffer" },
		},
		config = function() require("config.harpoon") end,
	},

	-- Git
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gvdiffsplit", "Glog" },
		config = function() require("config.fugitive") end,
	},

	-- Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.rose-pine")
			vim.cmd("colorscheme rose-pine")
		end,
	},
}

