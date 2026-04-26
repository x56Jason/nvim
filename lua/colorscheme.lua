local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local utils = require "telescope.utils"

local conf = require("telescope.config").values

local function do_telescope_colorscheme(opts)
	local before_background = vim.o.background
	local before_color = vim.api.nvim_exec("colorscheme", true)
	local need_restore = true

	--local colors = mycolorscheme.get_flavours()
	local colors = opts or { "kanagawa-wave", "catppuccin-mocha", "tokyonight-night", }

	local previewer
	-- define previewer
	local bufnr = vim.api.nvim_get_current_buf()
	local p = vim.api.nvim_buf_get_name(bufnr)

	-- don't need previewer
	if vim.fn.buflisted(bufnr) ~= 1 then
		vim.notify("Current buffer is not listed, can't do telescope-colorscheme!",
			vim.log.levels.INFO, {"do-telescope-colorscheme"})
		return
	end

	-- show current buffer content in previewer
	previewer = previewers.new_buffer_previewer {
		get_buffer_by_name = function()
			return p
		end,
		define_preview = function(self, entry)
			if vim.loop.fs_stat(p) then
				conf.buffer_previewer_maker(p, self.state.bufnr,
					{ bufname = self.state.bufname })
			else
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
			end
			vim.cmd("colorscheme " .. entry.value)
		end,
	}

	local picker = pickers.new(opts, {
		prompt_title = "Change ColorScheme",
		finder = finders.new_table { results = colors, },
		sorter = conf.generic_sorter(opts),
		previewer = previewer,
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				if selection == nil then
					utils.__warn_no_selection "mycolorscheme"
					return
				end

				actions.close(prompt_bufnr)
				need_restore = false
				vim.cmd("colorscheme " .. selection.value)
			end)

			return true
		end,
	})

	-- rewrite picker.close_windows. restore color if needed
	local close_windows = picker.close_windows
	picker.close_windows = function(status)
		close_windows(status)
		if need_restore then
			vim.o.background = before_background
			vim.cmd("colorscheme " .. before_color)
		end
	end

	picker:find()
end

local function my_telescope_colorscheme()
	do_telescope_colorscheme({
		"kanagawa-wave",
		"catppuccin-mocha",
		"kanagawa-dragon",
		"catppuccin-frappe",
		"catppuccin-macchiato",
		"catppuccin-latte",
		"tokyonight-night",
	})
end

local default_options = {noremap = true, silent = true}

vim.keymap.set("n", "fc", my_telescope_colorscheme, default_options)

-- rose-pine setup
require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    palette = {
        -- Override the builtin palette per variant
        -- moon = {
        --     base = '#18191a',
        --     overlay = '#363738',
        -- },
    },

	-- NOTE: Highlight groups are extended (merged) by default. Disable this
	-- per group via `inherit = false`
    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
-- vim.cmd("colorscheme monokai-pro")
