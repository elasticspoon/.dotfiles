return {
	{
		"nvim-neotest/neotest",
		lazy = true,
		dependencies = {
			-- "olimorris/neotest-rspec",
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
			},
		},
	},
}
