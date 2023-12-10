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
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup("plugins")

require("configs")

-- Vim mappings, see lua/config/which.lua for more mappings
require("mappings")

-- All non plugin related (vim) options
require("options")

-- Enable favorable colorscheme from installed ones
require("colorscheme")

-- Vim autocommands/autogroups
--require("autocmd")
