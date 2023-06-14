return {
	{ "mattn/emmet-vim" },
	{
		"windwp/nvim-ts-autotag",
		config = function(_, _)
			require("nvim-ts-autotag").setup()
		end,
	},
}
