-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local group_watcher = vim.api.nvim_create_augroup("FileWatch", {})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.postcss.css",
	group = group_watcher,
	command = "!yarn postcss ./app/assets/stylesheets/application.postcss.css -o ./app/assets/builds/application.css",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	group = vim.api.nvim_create_augroup("close_with_q_extra", { clear = true }),
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", function()
			require("mini.bufremove").delete(0, false)
		end, { buffer = event.buf, silent = true })
	end,
})
