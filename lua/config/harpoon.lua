local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
	},
})

local function my_harpoon_add_file()
	harpoon:list():append()

	local f = vim.api.nvim_buf_get_name(0)
	vim.notify("Harpoon: <" .. f .. "> added", vim.log.levels.INFO, {})
end

local toggle_opts = {
	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	ui_width_ratio = 0.375,
	title_pos = "center",
}

local function toggle_next_buffer()
	if harpoon:list():length() == 0 then
		vim.cmd("bnext")
	else
		harpoon:list():next({ui_nav_wrap = true})
	end
end

local function toggle_prev_buffer()
	if harpoon:list():length() == 0 then
		vim.cmd("bprevious")
	else
		harpoon:list():prev({ui_nav_wrap = true})
	end
end

vim.keymap.set("n", "m", function() my_harpoon_add_file() end)
vim.keymap.set("n", "MM", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)
vim.keymap.set("n", "M1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "M2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "M3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "M4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "M5", function() harpoon:list():select(5) end)

-- Tab switch buffer
vim.keymap.set("n", "<TAB>", function() toggle_next_buffer() end)
vim.keymap.set("n", "<S-TAB>", function() toggle_prev_buffer() end)
