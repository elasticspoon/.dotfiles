return {
	{
		"tpope/vim-rails",
		cmd = {
			"Eview",
			"Econtroller",
			"Emodel",
			"Smodel",
			"Sview",
			"Scontroller",
			"Vmodel",
			"Vview",
			"Vcontroller",
			"Tmodel",
			"Tview",
			"Tcontroller",
			"Rails",
			"Generate",
			"Runner",
			"Extract",
		},
	},
	{
		"mrjones2014/nvim-ts-rainbow",
	},

	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
	},
}
