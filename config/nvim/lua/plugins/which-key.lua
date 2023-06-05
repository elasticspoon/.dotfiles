return {
	{
		"folke/which-key.nvim",
		opts = {
			defaults = {
				["<leader>t"] = { name = "+test" },
				["<leader>d"] = { name = "+debug" },
				["<leader>da"] = { name = "+adapters" },
			},
		},
	},
}
