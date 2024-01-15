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
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"shfmt",
				"erb-lint",
				"prettier",
				"htmlbeautifier",
				"css-lsp",
				"html-lsp",
				"bash-language-server",
				"emmet-language-server",
				"stylua",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				emmet_language_server = {
					showSuggestionsAsSnippets = true,
				},
			},
		},
	},
}
