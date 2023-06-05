return {
	{ "antoinemadec/FixCursorHold.nvim" },
	-- { "olimorris/neotest-rspec" },
	-- { "zidhuss/neotest-minitest" },
	-- { "elasticspoon/neotest-minitest" },
	{ "vim-test/vim-test" },
	{ "nvim-neotest/neotest-vim-test" },
	{
		"nvim-neotest/neotest",
		opts = {
			-- Can be a list of adapters like what neotest expects,
			-- or a list of adapter names,
			-- or a table of adapter names, mapped to adapter configs.
			-- The adapter will then be automatically loaded with the config.
			adapters = {
				-- ["neotest-minitest"] = {},
				-- ["neotest-rspec"] = {},
				["neotest-vim-test"] = {},
			},
			-- Example for loading neotest-go with a custom config
			-- adapters = {
			--   ["neotest-go"] = {
			--     args = { "-tags=integration" },
			--   },
			-- },
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazyvim.util").has("trouble.nvim") then
						vim.cmd("Trouble quickfix")
					else
						vim.cmd("copen")
					end
				end,
			},
		},
	},
}
