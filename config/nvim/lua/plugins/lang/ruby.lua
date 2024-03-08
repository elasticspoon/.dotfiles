-- NOTE: This is in additon to the built in ruby configuration
-- provided by lazyvim in lazy.init
local lspconfig = require("lspconfig")

return {
	-- { "tpope/vim-bundler" },
	-- { "tpope/vim-rake" },
	-- { "vim-ruby/vim-ruby" },
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
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"ruby",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- Useful for debugging formatter issues
			servers = {
				-- ruby_ls = {
				-- -- cmd = { "bundle", "exec", "ruby-lsp" },
				-- cmd = { "ruby-lsp" },
				-- init_options = {
				-- 	formatter = "auto",
				-- },
				-- settings = {},
				-- },
				solargraph = {
					-- See: https://medium.com/@cristianvg/neovim-lsp-your-rbenv-gemset-and-solargraph-8896cb3df453
					cmd = { os.getenv("HOME") .. "/.asdf/shims/solargraph", "stdio" },
					root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
					-- settings = {
					-- 	solargraph = {
					-- 		autoformat = true,
					-- 		completion = true,
					-- 		diagnostics = true,
					-- 		folding = true,
					-- 		references = true,
					-- 		rename = true,
					-- 		symbols = true,
					-- 	},
					-- },
				},
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"suketa/nvim-dap-ruby",
			config = function()
				require("dap-ruby").setup()
			end,
		},
	},
	{
		"suketa/nvim-dap-ruby",
		config = function()
			require("dap-ruby").setup()
		end,
	},
	{
		"olimorris/neotest-rspec",
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"olimorris/neotest-rspec",
		},
		opts = {
			adapters = {
				["neotest-rspec"] = {
					-- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
					-- rspec_cmd = function()
					--   return vim.tbl_flatten({
					--     "bundle",
					--     "exec",
					--     "rspec",
					--   })
					-- end,
				},
			},
		},
	},
}
