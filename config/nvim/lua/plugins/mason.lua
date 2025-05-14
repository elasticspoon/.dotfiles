-- local function getOsConfig()
-- 	local config = {
-- 	}
--
-- 	if os.getenv("NIX_PATH") == nil and os.getenv("NIX_STORE") == nil then
--     config[servers][]
-- 	end
-- 	return serverInstalls
-- end

return {
	{ "mason-org/mason.nvim", version = "^1.0.0" },
	{ "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"actionlint",
				"shfmt",
				"erb-lint",
				"prettier",
				"htmlbeautifier",
				"css-lsp",
				"html-lsp",
				"bash-language-server",
				"emmet-language-server",
				"stylua",
				"sqlfluff",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			format_notify = true,
			inlay_hints = {
				enabled = false,
			},
			servers = {
				diagnosticls = {},
				dockerls = {},
				jsonls = {},
				postgres_lsp = {},
				emmet_language_server = {
					showSuggestionsAsSnippets = true,
				},
			},
		},
	},
}
