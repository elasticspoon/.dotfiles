-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local group_watcher = vim.api.nvim_create_augroup("FileWatch", {})

-- TODO: make the next two autocmds check if the needed gems
-- are installed before being created
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.erb",
	group = augroup,
	command = "!erblint -a --config ~/.erb-lint.yml %",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.postcss.css",
	group = group_watcher,
	command = "!yarn postcss ./app/assets/stylesheets/application.postcss.css -o ./app/assets/builds/application.css",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.erb",
	group = augroup,
	command = "!htmlbeautifier %",
})

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
	callback = function()
		vim.cmd("setlocal winhighlight=Normal:TelescopeResultsDiffDelete,NormalNC:Normal")
		local timer = vim.loop.new_timer()
		if timer == nil then
			return
		end
		timer:start(
			300,
			0,
			vim.schedule_wrap(function()
				vim.cmd("setlocal winhighlight=Normal:Normal,NomralNC:NormalNC")
			end)
		)
	end,
})
