return {
	{ "vim-test/vim-test" },
	{ "voldikss/vim-floaterm" },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "vertical",
			size = function()
				return vim.o.columns * 0.3
			end,
		},
	},
}
