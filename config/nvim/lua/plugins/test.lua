return {
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		"christoomey/vim-tmux-runner",
		init = function()
			vim.g["VtrOrientation"] = "h"
		end,
	},
	{
		"vim-test/vim-test",
		init = function()
			vim.g["test#strategy"] = "vtr"
			-- vim.g["test#preserve_screen"] = 0
		end,
	},
}
