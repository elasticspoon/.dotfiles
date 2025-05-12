-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.scrolloff = 8

opt.swapfile = false
opt.backup = false

opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true

opt.clipboard = "unnamedplus"
opt.tags = { ".tags", ".git/tags", ".gemtags" }

vim.g.snacks_animate = false
vim.g.lazyvim_cmp = "nvim-cmp"
-- LSP Server to use for Ruby.
-- Set to "solargraph" to use solargraph instead of ruby_lsp.
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"
