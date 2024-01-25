
local map = vim.api.nvim_set_keymap
local default_options = {noremap = true, silent = true}

map("n", "m", "<cmd>lua require('harpoon.mark').add_file()<CR>", default_options)
map("n", "MM", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", default_options)
map("n", "M1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", default_options)
map("n", "M2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", default_options)
map("n", "M3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", default_options)
map("n", "M4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", default_options)
map("n", "M5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", default_options)
