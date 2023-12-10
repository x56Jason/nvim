require("catppuccin").setup({
	flavor = "mocha",
	term_colors = true,
	transparent_background = false,
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		all = {
			base = "#000000",
			mantle = "#000000",
			crust = "#000000",
		},
	},
	custom_highlights = function(color)
		return {
			Function = { fg = "#84a0c6", style = O.styles.functions or {} }
		}
	end
})
