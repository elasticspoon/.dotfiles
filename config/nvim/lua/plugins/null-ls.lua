if true then
	return {}
end

-- Cannot figure out how to get null-ls to work with my current setup

return {
	{
		"lukas-reineke/lsp-format.nvim",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					-- nls.builtins.formatting.fish_indent,
					-- nls.builtins.diagnostics.fish,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.shfmt,
					nls.builtins.formatting.markdown_toc,
					nls.builtins.formatting.markdownlint,
					-- nls.builtins.diagnostics.flake8,
					nls.builtins.diagnostics.erb_lint,
					-- nls.builtins.formatting.prettierd,
					nls.builtins.formatting.htmlbeautifier,
				},
				on_attach = require("lsp-format").on_attach,
			}
		end,
	},
}
