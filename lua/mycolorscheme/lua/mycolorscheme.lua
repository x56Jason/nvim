local M = {
	default_options = {
		flavours = {
			"catppuccin",
			"kanagawa",
			"tokyonight",
		},
	}
}

M.flavours = {}

M.get_flavours = function()
	return M.flavours
end

function M.set_colorscheme_flavour(user_opt)
	M.flavours = user_opt or M.default_options.flavours

	for _, flavour in ipairs(M.flavours) do
		local status, _ = pcall(vim.cmd, string.format("colorscheme %s", flavour))
		if status then
			M.flavour = flavour
			return
		end
	end
end

return M
