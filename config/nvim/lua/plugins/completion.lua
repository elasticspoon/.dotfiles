return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		opts = function(_, opts)
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<S-CR>"] = cmp.mapping(function(fallback)
					fallback()
				end, { "i", "s", "c" }),
				["<CR>"] = cmp.mapping(function(fallback)
					fallback()
				end, { "i", "s", "c" }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm()
					else
						fallback()
					end
				end, { "i", "s", "c" }),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
}
