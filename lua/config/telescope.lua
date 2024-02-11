local telescope = require("telescope")
local actions = require("telescope.actions")

local function my_scroll_preview_page(prompt_bufnr, direction)
	local status = require "telescope.state".get_status(prompt_bufnr)
	status.picker.layout_config.scroll_speed = vim.api.nvim_win_get_height(status.preview_win)
	require "telescope.actions.set".scroll_previewer(prompt_bufnr, direction)
	status.picker.layout_config.scroll_speed = 1
end

local function my_scroll_results_page(prompt_bufnr, direction)
	local state = require "telescope.state".get_status(prompt_bufnr)
	local picker = state.picker
	local status_updater = picker:get_status_updater(picker.prompt_win, picker.prompt_bufnr)

	picker.layout_config.scroll_speed = vim.api.nvim_win_get_height(state.layout.results.winid)
	require "telescope.actions.set".scroll_results(prompt_bufnr, direction)
	picker.layout_config.scroll_speed = 1

	status_updater {completed = true}
end

local function my_get_status_text(self, opts)
	local ww = #(self:get_multi_selection())
	local xx = (self.stats.processed or 0) - (self.stats.filtered or 0)
	local yy = self.stats.processed or 0
	local status_icon = ""
	if opts and not opts.completed then
		status_icon = "*"
	end
	if xx == 0 and yy == 0 then
		return status_icon
	end
	local row = xx - (self.max_results - self:get_selection_row()) + 1
	if ww == 0 then
		return string.format("%s %s / %s / %s", status_icon, row, xx, yy)
	else
		return string.format("%s %s / %s / %s / %s", status_icon, ww, row, xx, yy)
	end
end

local function my_move_selection(prompt_bufnr, direction)
	local state = require "telescope.state"
	local picker = state.get_status(prompt_bufnr).picker
	local status_updater = picker:get_status_updater(picker.prompt_win, picker.prompt_bufnr)

	if direction == 1 then
		actions.move_selection_next(prompt_bufnr)
	elseif direction == -1 then
		actions.move_selection_previous(prompt_bufnr)
	end
	status_updater {completed = true}
end

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    }
  },
  defaults = {
    get_status_text = my_get_status_text,
    layout_strategy = 'vertical',
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
      height = 0.95,
      prompt_position = 'bottom',
      width = 0.95,
      preview_cutoff = 5,
      scroll_speed = 1,
    },
    file_ignore_patterns = { ".cache/", "%.o", "%.so", "%.a", "%.ko", "%.tar.gz" },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
	["<Up>"] = function (prompt_bufnr) my_move_selection(prompt_bufnr, -1) end,
	["<Down>"] = function (prompt_bufnr) my_move_selection(prompt_bufnr, 1) end,
        ["<PageUp>"] = function (prompt_bufnr) my_scroll_results_page(prompt_bufnr, -1) end,
        ["<PageDown>"] = function (prompt_bufnr) my_scroll_results_page(prompt_bufnr, 1) end,
        ["<C-Up>"] = require "telescope.actions".preview_scrolling_up,
        ["<C-Down>"] = require "telescope.actions".preview_scrolling_down,
        ["<C-PageUp>"] = function (prompt_bufnr) my_scroll_preview_page(prompt_bufnr, -1) end,
        ["<C-PageDown>"] = function (prompt_bufnr) my_scroll_preview_page(prompt_bufnr, 1) end,
        ["<c-e>"] = function(prompt_bufnr)
                actions.select_default(prompt_bufnr)
                require("telescope.builtin").resume()
        end,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ["<c-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<c-a>"] = actions.add_selected_to_qflist + actions.open_qflist,
      },
      n = {
	["<Up>"] = function (prompt_bufnr) my_move_selection(prompt_bufnr, -1) end,
	["<Down>"] = function (prompt_bufnr) my_move_selection(prompt_bufnr, 1) end,
        ["<PageUp>"] = function (prompt_bufnr) my_scroll_results_page(prompt_bufnr, -1) end,
        ["<PageDown>"] = function (prompt_bufnr) my_scroll_results_page(prompt_bufnr, 1) end,
        ["<C-Up>"] = require "telescope.actions".preview_scrolling_up,
        ["<C-Down>"] = require "telescope.actions".preview_scrolling_down,
        ["<C-PageUp>"] = function (prompt_bufnr) my_scroll_preview_page(prompt_bufnr, -1) end,
        ["<C-PageDown>"] = function (prompt_bufnr) my_scroll_preview_page(prompt_bufnr, 1) end,
        ["<c-e>"] = function(prompt_bufnr)
                actions.select_default(prompt_bufnr)
                require("telescope.builtin").resume()
        end,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ["<c-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<c-a>"] = actions.add_selected_to_qflist + actions.open_qflist,
      },
    }
  },
})

telescope.load_extension "fzf"

local function my_lsp_dynamic_workspace_symbols(user_opts)
	local opts = user_opts or {}
	local width = vim.api.nvim_win_get_width(0) / 4
	local tag_item = {
		tagname = vim.fn.expand('<cword>'),
		from = { vim.fn.bufnr('%'), vim.fn.line('.'), vim.fn.col('.'), 0 },
		winid = vim.fn.win_getid(),
	}

	opts.fname_width = width < 50 and 50 or width
	opts.attach_mappings = function(_, map)
		map("i", "<c-g>", actions.to_fuzzy_refine)
		map({"i", "n"}, "<CR>", function(prompt_bufnr)
			vim.fn.settagstack(tag_item.winid, { items = { tag_item } }, 't')
			actions.select_default(prompt_bufnr)
			vim.cmd.normal("zz")
		end)
		return true
	end
	require('telescope.builtin').lsp_dynamic_workspace_symbols(opts)
end

local function my_lsp_references()
	local opts = {temp__scrolling_limit=1000}
	local width = vim.api.nvim_win_get_width(0) / 4

	opts.jump_type = "never"
	opts.fname_width = width < 50 and 50 or width
	opts.include_current_line = true
	require('telescope.builtin').lsp_references(opts)
end

local function my_live_grep()
	local opts = {temp__scrolling_limit=1000}
	vim.fn.systemlist("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	end
	opts.attach_mappings = function(_, map)
		map("i", "<c-g>", actions.to_fuzzy_refine)
		return true
	end
	require('telescope.builtin').live_grep(opts)
end

local default_options = {noremap = true, silent = true}

vim.keymap.set("n", "fg", my_lsp_dynamic_workspace_symbols, default_options)
vim.keymap.set("n", "fb", "<cmd>Telescope buffers<CR>", default_options)
vim.keymap.set("n", "ff", "<cmd>Telescope find_files<CR>", default_options)
vim.keymap.set("n", "fw", "<cmd>Telescope workspaces<CR>", default_options)
vim.keymap.set("v", "fh", "<cmd>Telescope git_bcommits_range<CR>", default_options)
vim.keymap.set("n", "<C-\\>s", "<cmd>Telescope grep_string temp__scrolling_limit=1000<CR>", default_options)
vim.keymap.set("n", "<C-\\>t", my_live_grep, default_options)
vim.keymap.set("n", "<C-\\>r", my_lsp_references, default_options)
