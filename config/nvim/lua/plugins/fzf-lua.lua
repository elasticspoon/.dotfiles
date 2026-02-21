return {
	{ "ibhagwan/fzf-lua", opts = {
		fzf_opts = {
			["--layout"] = "default",
		},
	} },
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				enabled = false,
			},
		},
		keys = {
			{
				"<leader><leader>",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>/",
				function()
					require("fzf-lua").live_grep_native()
				end,
				desc = "Grep (Root Dir)",
			},
		},
	},
}
