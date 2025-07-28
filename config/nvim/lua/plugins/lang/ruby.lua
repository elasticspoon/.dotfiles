return {
	{ "tpope/vim-rails" },
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ruby_lsp = {
					mason = false,
					cmd = { "mise", "x", "--", "ruby-lsp" },
					init_options = {
						addonSettings = {
							["Ruby LSP Rails"] = {
								enablePendingMigrationsPrompt = false,
							},
						},
					},
				},
			},
		},
	},
}
