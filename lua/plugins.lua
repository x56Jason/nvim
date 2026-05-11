return {
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
	},

	{
		"neovim/nvim-lspconfig",
		cmd = "Mason",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			servers ={
				clangd = {
					mason = false,
					-- raspberry pi 5
					cmd = {"usr/bin/clangd"},
				},
			},
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
		event = "VeryLazy",
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
		version = false,
		event = "InsertEnter",
		dependencies = {
			{ "onsails/lspkind-nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
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

	{
		"ironhouzi/starlite-nvim",
		keys = {
			{ "*", "<cmd>lua require'starlite'.star()<CR>", desc = "Star search" },
			{ "g*", "<cmd>lua require'starlite'.g_star()<CR>", desc = "g* search" },
			{ "#", "<cmd>lua require'starlite'.hash()<CR>", desc = "Hash search" },
			{ "g#", "<cmd>lua require'starlite'.g_hash()<CR>", desc = "g# search" },
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("config.which") end,
	},

	{
		"yorickpeterse/nvim-window",
		keys = {
			{ "<leader>w", "<cmd>lua require('nvim-window').pick()<CR>", desc = "nvim-window Selection" },
		},
		config = function() require("config.nvim-window") end,
	},

	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		config = function() require("config.fugitive") end,
	},

	{
		"natecraddock/workspaces.nvim",
		cmd = { "WorkspacesOpen", "WorkspacesAdd", "WorkspacesList", "WorkspacesRemove" },
		config = function() require("config.workspaces") end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		opts = {
			user_default_options = {
				names = false,
				mode = "background",
			},
		},
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		event = "BufReadPost",
		config = function() require("config.mini-indentscope") end,
	},

	{
		"lukoshkin/highlight-whitespace",
		event = "BufReadPost",
		opts = {
			tws = "\\s\\+$",
			clear_on_bufleave = false,
			palette = {
				other = {
					tws = 'gray',
					['        '] = 'gray',
					[' \\t'] = 'gray',
				},
			},
		},
	},

	{
		"x56Jason/glance.nvim",
		cmd = "Glance",
		opts = {
			patchdiff = "diffonly",
			q_quit_log = "off",
		},
	},

	{
		"x56Jason/gitee.nvim",
		cmd = "Gitee",
		dependencies = { "x56Jason/glance.nvim" },
		opts = {
			token_file = "~/.token.gitee",
			repo = "openeuler/kernel",
		},
	},

	{
		"diepm/vim-rest-console",
		ft = "rest",
		config = function() require("config.vim-rest-console") end,
	},

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

	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = true,
	},
	{ "tpope/vim-sleuth", event = "BufReadPost" },

	{
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			{
				"<leader>si",
				"<cmd>Telescope hierarchy incoming_calls<cr>",
				desc = "LSP: [S]earch [I]ncoming Calls",
			},
			{
				"<leader>so",
				"<cmd>Telescope hierarchy outgoing_calls<cr>",
				desc = "LSP: [S]earch [O]utgoing Calls",
			},
		},
		opts = {
			extensions = {
				hierarchy = { },
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("hierarchy")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		event = "VeryLazy",
	},
	-- colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.rose-pine")
			vim.cmd("colorscheme rose-pine")
		end
	}
}

