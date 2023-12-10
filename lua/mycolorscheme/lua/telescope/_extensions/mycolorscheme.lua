local telescope = require "telescope"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local utils = require "telescope.utils"

local conf = require("telescope.config").values

local mycolorscheme = require("mycolorscheme")

mycolorscheme_picker = function(opts)
--  local before_background = vim.o.background
  local before_color = vim.api.nvim_exec("colorscheme", true)
  local need_restore = true

  local colors = mycolorscheme.get_flavours()
--  local colors = {"catppuccin-mocha", "tokyonight-night", "kanagawa-dragon"}

  local previewer
  -- define previewer
  local bufnr = vim.api.nvim_get_current_buf()
  local p = vim.api.nvim_buf_get_name(bufnr)

  -- don't need previewer
  if vim.fn.buflisted(bufnr) ~= 1 then
    local deleted = false
    local function del_win(win_id)
      if win_id and vim.api.nvim_win_is_valid(win_id) then
        utils.buf_delete(vim.api.nvim_win_get_buf(win_id))
        pcall(vim.api.nvim_win_close, win_id, true)
      end
    end

    previewer = previewers.new {
      preview_fn = function(_, entry, status)
        if not deleted then
          deleted = true
          if status.layout.preview then
            del_win(status.layout.preview.winid)
            del_win(status.layout.preview.border.winid)
          end
        end
        vim.cmd("colorscheme " .. entry.value)
      end,
    }
  else
    -- show current buffer content in previewer
    previewer = previewers.new_buffer_previewer {
      get_buffer_by_name = function()
        return p
      end,
      define_preview = function(self, entry)
        if vim.loop.fs_stat(p) then
          conf.buffer_previewer_maker(p, self.state.bufnr, { bufname = self.state.bufname })
        else
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
        end
        vim.cmd("colorscheme " .. entry.value)
      end,
    }
  end

  local picker = pickers.new(opts, {
    prompt_title = "Change ColorScheme",
    finder = finders.new_table {
      results = colors,
    },
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
--      vim.o.background = before_background
      vim.cmd("colorscheme " .. before_color)
    end
  end

  picker:find()
end

return telescope.register_extension({
    setup = function(ext_config)
        if ext_config.keep_insert then
            keep_insert = ext_config.keep_insert
        end
    end,

    exports = {
        mycolorscheme = function(opts)
            mycolorscheme_picker(opts)
        end,
    },
})
