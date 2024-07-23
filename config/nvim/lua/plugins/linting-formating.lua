return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				-- ["eruby"] = { "erb_format", "htmlbeautifier" },
				["eruby"] = { "erb_format" },
				-- ["javascript"] = { "prettier" },
				-- ["javascriptreact"] = { "prettier" },
				-- ["typescript"] = { "prettier" },
				-- ["typescriptreact"] = { "prettier" },
				["vue"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
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
