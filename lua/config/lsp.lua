local nvim_lsp = require("lspconfig")

local lsp_defaults = nvim_lsp.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

local nproc = string.gsub(vim.fn.system('nproc'), "\n", "")
nvim_lsp.clangd.setup {
	cmd = {
		"clangd",
		"--header-insertion=never",
		"-j", nproc,
		"--background-index",
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  end
})

nvim_lsp.rust_analyzer.setup({})

nvim_lsp.dockerls.setup {
	cmd = {
		"docker-langserver", "--stdio"
	},
	filetypes = { "dockerfile" },
	root_dir = nvim_lsp.util.root_pattern("Dockerfile"),
	single_file_support = true,
}

nvim_lsp.bashls.setup {
	cmd = {
		"bash-language-server", "start"
	},
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
	},
	filetypes = { "sh" },
	root_dir = nvim_lsp.util.find_git_ancestor,
	single_file_support = true,
}

nvim_lsp.pylsp.setup {
	cmd = { "pylsp" },
	filetypes = { "python" }
}

local lua_ls_root_path = os.getenv("HOME") .. "/lua-language-server"
local lua_ls_binary = lua_ls_root_path .. "/bin/lua-language-server"

nvim_lsp.lua_ls.setup {
	cmd = { lua_ls_binary, "-E", lua_ls_root_path .. "/main.lua"},
	settings = {
		Lua =  {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';')
			},
			completion = {enable = true, callSnippet = "Both"},
			diagnostics = {
				enable = true,
				globals = { 'vim', 'describe' },
				disable = { "lowercase-global" },
			},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
}

-- Diagnostics
vim.diagnostic.config({
  float = { source = "always", border = "rounded" },
  virtual_text = false,
  signs = true,
})

vim.keymap.set('n', '<C-E>', function()
	-- If we find a floating window, close it.
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= '' then
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = 'Toggle Diagnostics' })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, { border = "rounded" }
)
