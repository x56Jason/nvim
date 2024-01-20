--require("vim-rest-console")

vim.g.vrc_set_default_mapping = 0
vim.g.vrc_response_default_content_type = "application/json"
vim.g.vrc_output_buffer_name = "_OUTPUT.json"
vim.g.vrc_auto_format_response_patterns = {
	json = "jq",
}

local map = vim.api.nvim_set_keymap
local default_options = {noremap = true, silent = true}

map("n", "<leader>xr", ":call VrcQuery()<CR><cmd>wincmd l<CR>", default_options)
