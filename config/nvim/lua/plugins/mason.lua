-- local function getOsConfig()
-- 	local config = {
-- 	}
--
-- 	if os.getenv("NIX_PATH") == nil and os.getenv("NIX_STORE") == nil then
--     config[servers][]
-- 	end
-- 	return serverInstalls
-- end
local function getOsServers()
	local serverInstalls = {
		"shfmt",
		"erb-lint",
		"prettier",
		"htmlbeautifier",
		"css-lsp",
		"html-lsp",
		"bash-language-server",
		"emmet-language-server",
	}

	if os.getenv("NIX_PATH") == nil and os.getenv("NIX_STORE") == nil then
		vim.list_extend(serverInstalls, {
			"stylua",
		})
	end
	return serverInstalls
end

return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = getOsServers(),
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				emmet_language_server = {
					showSuggestionsAsSnippets = true,
				},
				-- html = {
				-- 	filetypes = {
				-- 		"html",
				-- 		"eruby",
				-- 		"erb",
				-- 	},
				-- 	init_options = {
				-- 		userLanguages = {
				-- 			eruby = "erb",
				-- 		},
				-- 	},
				-- },
				lua_ls = {
					mason = false,
					cmd = { "lua-language-server" },
				},
				solargraph = {
					mason = false,
					cmd = { "solargraph", "stdio" },
				},
			},
		},
	},
}
