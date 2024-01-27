local mark = require("harpoon.mark")
function my_harpoon_add_file()
	mark.add_file()
	local f = vim.api.nvim_buf_get_name(0)
	vim.notify("Harpoon: <" .. f .. "> added", vim.log.levels.INFO, {})
end

local map = vim.api.nvim_set_keymap
local default_options = {noremap = true, silent = true}

map("n", "m", "<cmd>lua my_harpoon_add_file()<CR>", default_options)
map("n", "MM", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", default_options)
map("n", "M1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", default_options)
map("n", "M2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", default_options)
map("n", "M3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", default_options)
map("n", "M4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", default_options)
map("n", "M5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", default_options)
