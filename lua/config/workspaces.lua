local workspaces = require("workspaces")

workspaces.setup({
    -- path to a file to store workspaces data in
    -- on a unix system this would be ~/.local/share/nvim/workspaces
    path = vim.fn.stdpath("data") .. "/workspaces",

    -- to change directory for nvim (:cd), or only for window (:lcd)
    -- deprecated, use cd_type instead
    -- global_cd = true,

    -- controls how the directory is changed. valid options are "global", "local", and "tab"
    --   "global" changes directory for the neovim process. same as the :cd command
    --   "local" changes directory for the current window. same as the :lcd command
    --   "tab" changes directory for the current tab. same as the :tcd command
    --
    -- if set, overrides the value of global_cd
    cd_type = "local",

    -- sort the list of workspaces by name after loading from the workspaces path.
    sort = true,

    -- sort by recent use rather than by name. requires sort to be true
    mru_sort = true,

    -- option to automatically activate workspace when opening neovim in a workspace directory
    auto_open = false,

    -- enable info-level notifications after adding or removing a workspace
    notify_info = true,

    -- lists of hooks to run after specific actions
    -- hooks can be a lua function or a vim command (string)
    -- lua hooks take a name, a path, and an optional state table
    -- if only one hook is needed, the list may be omitted
    hooks = {
        add = {},
        remove = {},
        rename = {},
        open_pre = {},
        open = {},
    },
})

local my_workspace_name = ''
local my_commit_workspace_name = ''
local my_commit_work_directory = ''

local utils = require("telescope.utils")

function my_checkout_commit_workspace()
	local buf_path = vim.api.nvim_buf_get_name(0)
	if buf_path:find("fugitive://", 1, true) ~= 1 then
		return
	end

	local toplevel, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, vim.fn.getcwd())
	if ret ~= 0 then
		print(string.format("%s%s", "failed: git rev-parse --show-toplevel at ", vim.fn.getcwd()))
		return
	end

	if my_workspace_name == '' then
		workspaces.add(toplevel[1])
		my_workspace_name = toplevel[1]:match("^.*/(.*)$")
	end
	my_commit_workspace_name = "commit-"..my_workspace_name
	my_commit_work_directory = "~/.COMMIT-WORKSPACE/"..my_commit_workspace_name

	local shell_command = ''
	local gwd = vim.fn.expand(my_commit_work_directory)

	local git_dir
	git_dir, ret = utils.get_os_command_output({ "git", "rev-parse", "--absolute-git-dir" }, vim.fn.getcwd())
	if ret ~= 0 then
		print(string.format("%s%s", "failed: git rev-parse --absolute-git-dir at ", vim.fn.getcwd()))
		return
	end
	local prefix = "fugitive://" .. git_dir[1] .. "//"
	local length = string.len(prefix)
	local hash = string.sub(buf_path, length + 1, length + 40)
	local filename = string.sub(buf_path, length + 40 + 2, -1)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	if vim.fn.isdirectory(gwd) ~= 0 then
		local gwd_head_hash
		gwd_head_hash, ret = utils.get_os_command_output({ "git", "rev-parse", "HEAD" }, gwd)
		if ret ~= 0 then
			print(string.format("%s%s", "failed: git rev-parse HEAD at ", gwd))
			return
		end
		if hash ~= gwd_head_hash then
			shell_command = '!cd ' .. gwd .. '; git checkout ' .. hash
		end
	else
		shell_command = '!git worktree add ' .. gwd .. ' ' .. hash
	end
	if shell_command ~= '' then
		vim.cmd(shell_command)
	end

	workspaces.add(gwd, my_commit_workspace_name)
	workspaces.open(my_commit_workspace_name)
	vim.notify(string.format("Switch to %s/%s", gwd, filename), vim.log.levels.INFO, {"COMMIT-WORKSPACE"})
	vim.cmd(string.format("edit %s", filename))
	vim.api.nvim_win_set_cursor(0, {row, col})
end

local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}

map("n", "<leader>w", "<cmd>lua my_checkout_commit_workspace()<CR>", default_options)
