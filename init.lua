local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.termguicolors = true
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup("plugins")

-- Vim mappings, see lua/config/which.lua for more mappings
require("mappings")

-- All non plugin related (vim) options
require("options")

-- Vim autocommands/autogroups
require("autocmds")

-- Colorscheme picker (theme is set by rose-pine plugin)
require("colorscheme")

-- set layout 3 split
vim.api.nvim_create_user_command('Layout', function ()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.cmd("split")
  vim.cmd("wincmd j")
  vim.cmd("terminal")
  vim.cmd("wincmd h")
end, {})
