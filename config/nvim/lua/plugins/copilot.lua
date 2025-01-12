return {
	{
		"zbirenbaum/copilot.lua",
		opts = {
			filetypes = {
				ruby = true,
				c = true,
				lua = true,
				javascript = true,
				typescript = true,
				nix = true,
				bash = true,
				sh = true,
				go = true,
				["*"] = false,
			},
		},
		keys = {
      -- stylua: ignore start
      { "<M-]>", mode = "i", function() require("copilot.sugestion").next() end },
			-- stylua: ignore end
		},
	},
}

-- return {
-- 	{
-- 		"zbirenbaum/copilot.lua",
-- 		cmd = "Copilot",
-- 		build = ":Copilot auth",
-- 		opts = {
-- 			suggestion = {
-- 				enabled = true,
-- 				autotrigger = true,
-- 			},
-- 			panel = { enabled = false },
-- 			filetypes = {
-- 				ruby = true,
-- 				javascript = true,
-- 				typescript = true,
-- 				["*"] = false,
-- 			},
-- 		},
-- 	},
-- }
