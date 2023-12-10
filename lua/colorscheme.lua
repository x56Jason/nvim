require'mycolorscheme'.set_colorscheme_flavour({
	"catppuccin-mocha",
	"kanagawa-wave",
	"kanagawa-dragon",
	"catppuccin-frappe",
	"catppuccin-macchiato",
	"catppuccin-latte",
	"tokyonight-night",
})

local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}

map("n", "fc", "<cmd>Telescope mycolorscheme<CR>", default_options)
