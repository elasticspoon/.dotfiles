return {
	-- {
	-- 	"github/copilot.vim",
	-- },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		opts = {
			filetypes = {
				ruby = true,
				javascript = true,
				typescript = true,
				["*"] = false,
			},
		},
	},
}
