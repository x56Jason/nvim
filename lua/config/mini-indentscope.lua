require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"alpha",
		"dashboard",
		"neo-tree",
		"Trouble",
		"trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
		"lazyterm",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		--vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "@lsp.type.comment" })
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#393836"})
	end,
})
