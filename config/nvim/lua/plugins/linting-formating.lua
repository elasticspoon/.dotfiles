return {
	{
		"nvim-treesitter/playground",
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				-- ["eruby"] = { "erb_format", "htmlbeautifier" },
				["sql"] = { "pg_format" },
				["ruby"] = { "rubocop" },
				["eruby"] = { "erb_format" },
				-- ["javascript"] = { "prettier" },
				-- ["javascriptreact"] = { "prettier" },
				-- ["typescript"] = { "prettier" },
				-- ["typescriptreact"] = { "prettier" },
				["vue"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
				["sql"] = { "sqlfluff" },
				["less"] = { "prettier" },
				["html"] = { "prettier" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				["yaml"] = { "prettier" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["graphql"] = { "prettier" },
				["handlebars"] = { "prettier" },
				["nunjucks"] = { "prettier" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			-- Event to trigger linters
			linters_by_ft = {
				eruby = { "erb_lint" },
			},
		},
	},
}
