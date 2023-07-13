return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"ruby",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"solargraph",
				"erb-lint",
				"standardrb",
				"htmlbeautifier",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				solargraph = {},
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
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"olimorris/neotest-rspec",
			"elasticspoon/neotest-minitest",
		},
		opts = {
			adapters = {
				["neotest-minitest"] = {
					test_cmd = function()
						return vim.tbl_flatten({
							"ruby",
							"-Itest",
						})
					end,
				},
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
