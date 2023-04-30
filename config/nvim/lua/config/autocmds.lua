-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.erb",
	group = augroup,
	command = "!erblint -a --config ~/.erb-lint.yml %",
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
