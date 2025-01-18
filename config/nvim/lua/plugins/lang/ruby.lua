-- NOTE: This is in additon to the built in ruby configuration
-- provided by lazyvim in lazy.init

return {
	{ "tpope/vim-rails" },
	{
		"adam12/ruby-lsp.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = true,
	},
}
