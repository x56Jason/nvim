local lspconfig = require('lspconfig')

local nproc = string.gsub(vim.fn.system('nproc'), "\n", "")

local ensure_servers = {
	"clangd@16.0.2",
	"lua_ls",
}

local server_opts = {
	["clangd"] = {
		cmd = {
			"clangd",
			"--header-insertion=never",
			"-j", nproc,
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--limit-references=0",
			"--limit-results=0",
			"--rename-file-limit=0",
			"--background-index",
			"--background-index-priority=normal",
		},
		filetypes = {"c", "cpp", "objc", "objcpp"},
	},

	["lua_ls"] = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT'
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						vim.fn.stdpath("data") .. "/lazy/",
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					},
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file("", true)
				},
			},
		},
	},

	["bashls"] = {
		cmd = {
			"bash-language-server", "start"
		},
		cmd_env = {
			GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
		},
		filetypes = { "sh" },
		root_dir = lspconfig.util.find_git_ancestor,
		single_file_support = true,
	},

	["pylsp"] = {
		cmd = { "pylsp" },
		filetypes = { "python" }
	},

}

local server_handlers = {
	function (server_name)
		local opts = server_opts[server_name] or {}
		lspconfig[server_name].setup(opts)
	end,
}

local mason_opts = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require('mason').setup(mason_opts)
require('mason-lspconfig').setup({
	ensure_installed = ensure_servers,
	automatic_installation = true,
	handlers = server_handlers,
})

