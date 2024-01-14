return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"nix",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"nil",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				nil_ls = {},
			},
		},
	},
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = { "mason.nvim" },
	-- 	opts = function(_, opts)
	-- 		-- add tsx and treesitter
	-- 		local nls = require("null-ls")
	-- 		vim.list_extend(opts.sources, {
	-- 			nls.builtins.code_actions.statix,
	-- 			nls.builtins.diagnostics.deadnix,
	-- 			nls.builtins.formatting.alejandra,
	-- 			nls.builtins.formatting.nixpkgs_fmt,
	-- 		})
	-- 	end,
	-- 	-- opts = function()
	-- 	-- 	local nls = require("null-ls")
	-- 	-- 	return {
	-- 	-- 		root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
	-- 	-- 		sources = {
	-- 	-- 			-- nls.builtins.formatting.fish_indent,
	-- 	-- 			-- nls.builtins.diagnostics.fish,
	-- 	-- 			nls.builtins.formatting.stylua,
	-- 	-- 			nls.builtins.formatting.shfmt,
	-- 	-- 			nls.builtins.formatting.markdown_toc,
	-- 	-- 			-- nls.builtins.diagnostics.flake8,
	-- 	-- 			nls.builtins.diagnostics.erb_lint,
	-- 	-- 			nls.builtins.formatting.htmlbeautifier,
	-- 	-- 		},
	-- 	-- 		on_attach = require("lsp-format").on_attach,
	-- 	-- 	}
	-- 	-- end,
	-- },
}
