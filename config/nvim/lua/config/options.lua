-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.scrolloff = 8

opt.swapfile = false
opt.backup = false

opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true

opt.clipboard = "unnamed"
opt.tags = { ".tags", ".git/tags", ".gemtags" }

vim.g.snacks_animate = false
vim.g.lazyvim_cmp = "nvim-cmp"
